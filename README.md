# rails-bank-account

# Stack
- Ruby 3.1.1
- Rails 7.0.4.3
- Sqlite
- Tailwind

# Setup
- `bin/setup`
- docker-compose up (build image and create postgresql database container)
- gem install foreman (run rails s with tailwind)

# Problems with setup
- Error when installing PG gem
```
sudo apt install libpq-dev
```

- Error related to postgres with rails console
```
brew install libpq postgresql@14
```

# Heroku
- deploy -> git push heroku main
- migrate -> heroku run rake db:migrate

# Run application
- `bin/dev`

# App endpoints (POST)
- Create User
http://127.0.0.1:3000/api/v1/user
```json
{
    "email": "banana@bol.com"
}
```
<br>

- Create Bank Account
http://127.0.0.1:3000/api/v1/bank_account
```json
{
    "user_id": 3,
    "bank_number": "123",
    "agency_number": "123",
    "account_number": "123"
}
```
<br>

- Credit
http://127.0.0.1:3000/api/v1/credit
```json
{
    "bank_number": "123",
    "agency_number": "123",
    "account_number": "123",
    "amount_cents": "1000"
}
```
<br>

- Debit
http://127.0.0.1:3000/api/v1/debit
```json
{
    "bank_number": "123",
    "agency_number": "123",
    "account_number": "123",
    "amount_cents": "1000"
}
```
