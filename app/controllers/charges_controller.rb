require_relative '../models/amount'

class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: Amount.default 
    }
  end

  def create
    @was_standard = (current_user.role == "standard")

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Blocipedia Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:success] = "Thanks for upgrading your account, #{current_user}!"
    current_user.upgrade! # Upgrade user if charge went through successfully
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    user.downgrade! if @was_standard # We don't want to take away their premium membership if they were premium before
    redirect_to new_charge_path
  end
end

