module Api::V1
  class BankAccountsController < ApplicationController
    # skips CSRF protection, add to api controller
    skip_before_action :verify_authenticity_token

    def create
      bank_account = BankAccount.create(
        user_id: User.find(received_params[:user_id]).id,
        bank_number: received_params[:bank_number],
        agency_number: received_params[:agency_number],
        account_number: received_params[:account_number]
      )

      render json: {
        message: "Created bank account with #{received_params[:account_number]}",
        id: bank_account.id
      }, status: :created
    end

    private

    def received_params
      params.permit(:ureceived_paramsser_id, :bank_number, :agency_number, :account_number)
    end
  end
end
