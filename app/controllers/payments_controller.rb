class PaymentsController < ApplicationController
  before_action :authenticate_user!

  expose(:payments)
  expose(:payment, attributes: :payment_params)

  def create
    if payment.save
      redirect_to payment_path(payment), notice: I18n.t('shared.created', resource: 'Payment')
    else
      render :new
    end
  end

  def update
    if payment.save
      redirect_to payment_path(payment), notice: I18n.t('shared.updated', resource: 'Payment')
    else
      render :edit
    end
  end

  def destroy
    payment.destroy
    redirect_to payments_path, notice: I18n.t('shared.deleted', resource: 'Payment')
  end


  private

    def payment_params
      params.require(:payment).permit(:student_id, :amount)
    end
end
