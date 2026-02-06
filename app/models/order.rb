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

  enum status: { pending: 'pending', accepted: 'accepted', in_transit: 'in_transit', rejected: 'rejected', completed: 'completed' }
  enum :payment_type, { cash_on_delivery: "cash_on_delivery", upi: "upi" }

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
