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
    @user = current_user
    @was_standard = (@user.role == 'standard')

    if @was_standard
      customer = Stripe::Customer.create(
        email: @user.email,
        card: params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: Amount.default,
        description: "Blocipedia Membership - #{@user.email}",
        currency: 'usd'
      )

      flash[:success] = "Thanks for upgrading your account, #{@user}!"
      @user.update(role: 'premium')
      redirect_to root_path
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    @user.update(role: 'standard') if !@was_standard # We don't want to take away their premium membership if they were premium before
    redirect_to new_charge_path
  end
end

