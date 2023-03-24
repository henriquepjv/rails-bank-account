class BankAccountsController < ApplicationController
  def new
    @resource = BankAccount.new
  end

  def create
    @user = User.find_by(auth: session.dig('user_info', 'sub'))
    @resource = BankAccount.new(resource_params)
    @resource.user_id = @user.id
    if @resource.valid?
      @resource.save!

      redirect_to dashboard_path, notice: "Bank Account created!"
    else
      render :new, notice: 'erro'
    end
  end

  private

  def resource_params
    params.require(:bank_account).permit(:bank_number, :agency_number, :account_number)
  end
end

