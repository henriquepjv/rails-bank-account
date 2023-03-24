class BankAccount < ApplicationRecord
  belongs_to :user
  has_many :financial_entries

  def current_balance
    financial_entries.sum(:amount_cents)
  end
end
