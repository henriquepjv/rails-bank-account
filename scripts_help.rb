# criar bank account
ba = BankAccount.create(user_id: User.last.id, bank_number: 123, agency_number: 123, account_number: 123)
