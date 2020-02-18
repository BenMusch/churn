class LinksController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    public_token = link_params[:public_token]
    exchange_token_response = PLAID_CLIENT.item.public_token.exchange(public_token)
    access_token = exchange_token_response.access_token
    transaction_response = PLAID_CLIENT.transactions.get(access_token, '2019-07-12', '2020-02-14')
    transactions = transaction_response.transactions
    render json: transactions
  end

  private

  def link_params
    params.require(:link).permit(:public_token)
  end
end
