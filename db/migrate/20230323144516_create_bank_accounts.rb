class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|

      t.string :name
      t.integer :bank_number
      t.integer :agency_number
      t.integer :account_number
      t.integer :balance, default: 0
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
