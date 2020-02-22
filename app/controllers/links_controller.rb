class LinksController < ApplicationController
  before_action :authenticate_user!

  def new
    @accounts = current_user.linked_accounts
  end

  def create
    public_token = link_params[:public_token]
    plaid_data = JSON.parse(link_params[:metadata])

    if Institution.exists?(plaid_id: plaid_data["institution"]["id"])
      institution = Institution.find_by!(plaid_data["institution"]["id"])
    else
      institution = Institution.create!(
        plaid_id: plaid_data["institution"]["id"],
        name: plaid_data["institution"]["name"]
      )
    end

    accounts = plaid_data["accounts"].map do |account_data|
      LinkedAccount.create_from_plaid_data!(account_data, institution, current_user)
    end

    exchange_token_response = PLAID_CLIENT.item.public_token.exchange(public_token)
    access_token = exchange_token_response.access_token
    transaction_response = PLAID_CLIENT.transactions.get(access_token, "2019-07-12", "2020-02-14")
    transactions = transaction_response.transactions

    accounts.each do |account|
      account_transactions = transactions.select { |t| t["account_id"] == account.plaid_id }
      TRANSACTION_CACHE.set(account, account_transactions)
    end
    render json: transactions
  end

  private

  def link_params
    params.require(:link).permit(:public_token, :metadata)
  end
end
