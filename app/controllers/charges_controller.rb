# require '/Users/Andre/Documents/Bloc_Projects/code/blocipedia/app/lib/upgrade_amount'
require_relative '../lib/upgrade_amount'

class ChargesController < ApplicationController
  def create

    # Creates a Stripe Customer Object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "BigMoney Membership -  #{current_user.email}",
      currency: 'usd'
    )

    # Update user account if charge is successfull
    if charge.status == "succeeded"
      current_user.premium!
    end

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to edit_user_registration_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: Amount.default
    }
  end
end
