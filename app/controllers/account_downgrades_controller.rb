class AccountDowngradesController < ApplicationController

  def account_downgrade
    current_user.premium_to_standard
    redirect_to edit_user_registration_path
  end
end
