# Not an ActiveRecord model, wraps a transaction from plaid's API
class Transaction
  attr_reader :account_id, :amount, :date, :iso_currency_code, :payment_channel,
              :payment_meta, :pending, :transaction_type, :category, :name

  def initialize(account_id:,
                 amount:,
                 category:,
                 date:,
                 name:,
                 payment_channel:,
                 transaction_type:,
                 iso_currency_code: "USD",
                 payment_meta: {},
                 pending: false)
    @account_id = account_id
    @amount = amount
    @category = category
    @date = date
    @name = name
    @payment_channel = payment_channel
    @transaction_type = transaction_type
    @iso_currency_code = iso_currency_code
    @payment_meta = payment_meta
    @pending = pending
  end

  def self.load_from_plaid(plaid_data)
    date = Date.parse(plaid_data["date"])
    category = Category.find_by(plaid_id: plaid_data["category_id"])
    new(date: date,
        category: category,
        account_id: plaid_data["account_id"],
        amount: plaid_data["amount"],
        name: plaid_data["name"],
        payment_channel: plaid_data["payment_channel"],
        transaction_type: plaid_data["transaction_type"],
        iso_currency_code: plaid_data["iso_currency_code"],
        payment_meta: plaid_data["payment_meta"],
        pending: plaid_data["pending"])
  end
end
