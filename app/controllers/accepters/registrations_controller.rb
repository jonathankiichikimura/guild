class Accepters::RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:accepter).permit(:full_name, :suburb, :email, :password, :password_confirmation)
  end
end
