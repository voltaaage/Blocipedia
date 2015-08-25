require 'spec_helper'
require 'rails_helper'

describe Wiki do

  include TestFactories

  before do
      # setup
      user1 = authenticated_user
      user2 = authenticated_user
      users = User.all
      wiki = Wiki.new(id: 998, title: "This is a test wiki")
      # create a test factory for wikis?
  end

  context '#collaboration_exists?' do

    xit 'determines whether a user is a collaborator for the wiki' do

    end

    

  end

  context '#can_modify_wiki?' do

    xit 'identifies whether the user is a collaborator' do

    end

    xit 'identifies whether the user is an admin' do

    end

  end

  context '#private?' do

    xit 'tells you if the wiki is private' do

    end

  end

  context '#public?' do

    xit 'tells you if the wiki is public' do

    end

  end

end