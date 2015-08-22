class PaymentDecorator < BaseDecorator
  def payment_date
    created_at.strftime("%d %b %Y")
  end

  def dollars
    "$%.2f" % amount
  end
end
