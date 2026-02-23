class Order < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :vendor, optional: true
  belongs_to :farmer, optional: true
  belongs_to :address, optional: true
  has_many :order_items, dependent: :destroy
  
  # accepts_nested_attributes_for :order_items, allow_destroy: true
  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: proc { |att| att['item_id'].blank? }
  
  after_create :generate_invoice_number
  before_save :calculate_totals
  after_update :deduct_inventory, if: :saved_change_to_status?

  enum status: { pending: 'pending', accepted: 'accepted', in_transit: 'in_transit', rejected: 'rejected', completed: 'completed' }
  enum :payment_type, { cash_on_delivery: "cash_on_delivery", upi: "upi" }

  def update_total
    calculate_totals
    self.save!
  end

  def deduct_inventory
    return unless status == "accepted"

    order_items.each do |order_item|
      create_inventory_transactions(order_item)
    end
  end

  def create_inventory_transactions(order_item)
    item = order_item.item
    quantity_needed = order_item.quantity

    inventories = item.inventories
                      .where("remaining_quantity > 0")
                      .order(:stock_date)

    inventories.each do |inventory|
      break if quantity_needed <= 0

      deduct_qty = [inventory.remaining_quantity, quantity_needed].min

      # Create inventory transaction
      InventoryTransaction.create!(
        order_item: order_item,
        inventory: inventory,
        quantity: deduct_qty,
        cost_price: inventory.cost_price
      )

      inventory.update!(
        remaining_quantity: inventory.remaining_quantity - deduct_qty
      )

      quantity_needed -= deduct_qty
    end
  end

  # If status changes to cancelled:
  def restore_inventory
    inventory_transactions.each do |txn|
      txn.inventory.increment!(:remaining_quantity, txn.quantity)
    end
  end

  def sufficient_stock?
    order_items.all? do |oi|
      oi.item.total_available_stock >= oi.quantity
    end
  end


  private

  def generate_invoice_number
    self.invoice_number = "VGN10000#{id}"
    self.save!
  end

  def calculate_totals
    self.sub_total = order_items.collect { |oi| oi.quantity * oi.price_at_order.to_f }.sum
    self.total_amount = (sub_total || 0) + (delivery_charge || 0) - (discount || 0)
  end
end
