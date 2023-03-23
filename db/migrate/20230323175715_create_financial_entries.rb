class CreateFinancialEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :financial_entries do |t|

      t.integer :amount_cents
      t.references :bank_account, foreign_key: true
      t.timestamps
    end
  end
end
