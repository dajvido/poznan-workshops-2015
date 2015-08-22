require 'rails_helper'

RSpec.describe PaymentsController do
  let(:user) { create :user }

  before { sign_in user }

  describe 'GET #show' do
    let(:payment) { create :payment }
    it "returns http success" do
      get :show, id: payment.id
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #index' do
    subject { get :index }

    it_behaves_like 'template rendering action', :index
  end

  describe 'GET #edit' do
    let(:payment) { create :payment }
    subject { get :edit, id: payment.id }

    it_behaves_like 'template rendering action', :edit
  end

  describe 'GET #new' do
    subject { get :new }

    it_behaves_like 'template rendering action', :new
  end

  describe 'POST #create' do
    let!(:params) { { payment: build(:payment).attributes } }
    subject { post :create, params }

    context 'success' do
      it { is_expected.to redirect_to payment_path(controller.payment) }

      it 'flashes info' do
        subject
        expect(flash[:notice]).to eq I18n.t('shared.created', resource: 'Payment')
      end

      it 'creates payment' do
        expect{ subject }.to change(Payment, :count).by(1)
      end
    end

    context 'failure' do
      include_context 'record save failure'

      it_behaves_like 'template rendering action', :new
    end
  end

  describe 'PUT #update' do
    let!(:payment) { create :payment, amount: 700.00 }
    let(:amount) { 300.0 }
    let!(:params) do
      { id: payment.id, payment: { amount: amount } }
    end
    subject { put :update, params }

    context 'success' do
      it { is_expected.to redirect_to payment_path(controller.payment) }

      it 'flashes info' do
        subject
        expect(flash[:notice]).to eq I18n.t('shared.updated', resource: 'Payment')
      end

      context 'updates payment' do
        subject { -> { put :update, params } }
        it { is_expected.to change{ payment.reload.amount }.to(amount) }
      end
    end

    context 'failure' do
      include_context 'record save failure'

      it_behaves_like 'template rendering action', :edit
    end
  end

  describe 'DELETE #destroy' do
    let!(:payment) { create :payment }
    subject { delete :destroy, id: payment.id }

    it { is_expected.to redirect_to payments_path }

    it 'flashes info' do
      subject
      expect(flash[:notice]).to eq I18n.t('shared.deleted', resource: 'Payment')
    end

    it 'destroys payment' do
      expect{ subject }.to change(Payment, :count).by(-1)
    end
  end
end
