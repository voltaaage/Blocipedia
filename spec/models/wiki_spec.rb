require 'spec_helper'
require 'rails_helper'

describe Wiki do

  include TestFactories

  context '#create_collaborator' do

    it 'creates a collaborator' do

      # setup
      user1 = authenticated_user
      user2 = authenticated_user
      users = User.all
      wiki = Wiki.new(id: 998, title: "This is a test wiki")
      found_user_1 = false
      found_user_2 = false

      # function we are testing
      wiki.create_collaborator(users)

      # find collaborator models
      wiki_specific_collaborators = Collaborator.where(wiki_id: wiki_id)

      # expectations
      wiki_specific_collaborators.each do |collaborator|
        if collaborator.user_id == user1.id
          found_user_1 = true
        elsif collaborator.user_id == user2.id
          found_user_2 = true
        end          
      end

      expect(found_user_1 && found_user_2).to be_true
    end

  end

end