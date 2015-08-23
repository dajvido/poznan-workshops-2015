require 'spec_helper'

describe PaymentDecorator do
  let(:payment) { create :payment, amount: 700 }

  describe "#payment_date" do
    subject { payment.decorate.payment_date }
    it { is_expected.to eq payment.created_at.strftime("%d %b %Y") }
  end

  describe "#dollars" do
    subject { payment.decorate.dollars }
    it { is_expected.to eq '$700.00' }
  end


end
