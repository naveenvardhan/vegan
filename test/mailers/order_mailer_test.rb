require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "invoice_email" do
    mail = OrderMailer.invoice_email
    assert_equal "Invoice email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
