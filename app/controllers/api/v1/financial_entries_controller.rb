# frozen_string_literal: true

module Api::V1
  class FinancialEntriesController < ApplicationController
    # skips CSRF protection, add to api controller
    skip_before_action :verify_authenticity_token

    def credit
      bank_account = search_bank_account

      return { error: 'Bank account not found' }, status: :bad_request if bank_account.blank?

      FinancialEntry.create(
        amount_cents: received_params[:amount_cents],
        bank_account_id: bank_account.id
      )

      render json: { message: "Credit #{received_params[:amount_cents]}" }, status: :created
    end

    def debit
      bank_account = search_bank_account

      return { error: 'Bank account not found' }, status: :bad_request if bank_account.blank?

      FinancialEntry.create(
        amount_cents: -(received_params[:amount_cents]),
        bank_account_id: bank_account.id
      )

      render json: { message: "Debit #{received_params[:amount_cents]}" }, status: :created
    end

    private

    def search_bank_account
      BankAccount.where(
        bank_number: received_params[:bank_number],
        agency_number: received_params[:agency_number],
        account_number: received_params[:account_number]
      ).first
    end

    def received_params
      params.permit(
        :bank_number, :agency_number, :account_number, :amount_cents
      )
    end
  end
end
