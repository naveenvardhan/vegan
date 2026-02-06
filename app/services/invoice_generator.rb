class InvoiceGenerator
  def initialize(order)
    @order = order
  end

  # def render
  #   Prawn::Document.new do |pdf|
  #     pdf.text "INVOICE: #{@order.invoice_number}", size: 25, style: :bold
  #     pdf.text "Vendor: #{@order.vendor.name}"
  #     pdf.move_down 20
  # 
  #     pdf.table([["Item", "Qty", "Price"]] + 
  #       @order.order_items.map { |oi| [oi.item.name, oi.quantity, oi.item.price] })
  # 
  #     pdf.move_down 20
  #     pdf.text "Total Amount: $#{@order.total_price}", size: 16, style: :bold
  #   end.render
  # end
end