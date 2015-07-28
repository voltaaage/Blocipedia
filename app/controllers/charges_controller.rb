class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: Amount.default
    }
  end

  def create
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

    flash[:success] = "Thanks for upgrading your account, #{current_user}! Feel free to invite others to upgrade as well!"
    redirect_to user_path(current_user)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end

