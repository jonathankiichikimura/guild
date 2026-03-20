class Givers::RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:giver).permit(:first_name, :suburb, :email, :password, :password_confirmation,
                                   :emergency_contact_name, :emergency_contact_phone)
  end
end
