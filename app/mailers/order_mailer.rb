class OrderMailer < ApplicationMailer

  def invoice_email(order)
    @order = order
    @customer = order.customer
    mail(to: @customer.email, subject: "Your Invoice for Order ##{@order.id}")
  end
end
