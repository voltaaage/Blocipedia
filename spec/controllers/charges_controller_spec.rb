require 'spec_helper'
require 'rails_helper'

describe ChargesController, type: :controller do

  include TestFactories

    context "POST create" do
      before(:each) do
        standard_user = authenticated_user
        premium_user = authenticated_user(role: 'premium')
      end

      it 'upgrades a standard user to a premium user' do
        standard_user = authenticated_user
        allow(:standard_user).to receive(:authenticate)
        post :create, {user: standard_user}
        expect(standard_user.role).to eql('premium')
      end

      xit 'does not charge a user who is already a premium user' do

      end

      xit 'does not charge a user who is not logged in' do

      end

    end  
end
