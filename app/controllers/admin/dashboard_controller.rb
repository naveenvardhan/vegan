class Admin::DashboardController < Admin::BaseController
  def index
    @from_date = params[:from_date].present? ? Date.parse(params[:from_date]) : Date.today
    @to_date   = params[:to_date].present? ? Date.parse(params[:to_date]) : Date.today
    date_range = @from_date.beginning_of_day..@to_date.end_of_day

    orders = Order.where(order_date: date_range)

    @total_orders  = orders.count
    @total_amount  = orders.sum(:total_amount)

    order_items = OrderItem.joins(:order)
                           # .where(orders: { id: orders.pluck(:id) })
                           .where(orders: { order_date: date_range })

    @total_items_sold = order_items.sum(:quantity)

    # @total_profit = order_items.joins(:item)
    #                            .sum(" (order_items.price_at_order - items.cost_price) * order_items.quantity ")
                               
    @total_profit = InventoryTransaction.joins(:order_item)
                    .joins(order_item: :order)
                    .where(orders: { order_date: date_range })
                    .sum("(order_items.price_at_order - inventory_transactions.cost_price) * inventory_transactions.quantity")
                    
    @items_ordered = order_items
                      .joins(:item)
                      .select(
                        "items.id,
                         items.name,
                         SUM(order_items.quantity) as total_quantity,
                         SUM(order_items.quantity * order_items.price_at_order) as total_sales"
                      )
                      .group("items.id, items.name")
                      .order("total_quantity DESC")

                           
  end
end
