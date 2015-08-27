require 'spec_helper'
require 'rails_helper'

describe Wiki do

  include TestFactories

  let!(:user) { authenticated_user }
  let!(:wiki) { Wiki.new }
  let!(:collaborator) { Collaborator.create(wiki: wiki, user: user) }

  describe '#collaboration_exists' do
    let(:user_2) { authenticated_user }

    it 'return true if user is a collaborator' do 
      expect(wiki.collaboration_exists?(user)).to eq(true)
    end


    it 'returns false if user is not a collaborator' do
      expect(wiki.collaboration_exists?(user_2)).to eq(false)
    end

  end

  describe '#can_modify_wiki?(user)' do
    context 'true' do
      it 'should be able to modify if the user is a collaborator' do
        allow(wiki).to receive(:collaboration_exists?).with(user).and_return(true)
        allow(user).to receive(:role).and_return('not admin')

        expect(wiki.can_modify_wiki?(user)).to eq(true)
      end

      it 'should be able to modify the user is an admin' do
        allow(wiki).to receive(:collaboration_exists?).with(user).and_return(false)
        allow(user).to receive(:role).and_return('admin')

        expect(wiki.can_modify_wiki?(user)).to eq(true)
      end
    end

    context 'false' do
      it 'should not be able to modify if the user is not a collaborator nor an admin' do
        allow(wiki).to receive(:collaboration_exists?).with(user).and_return(false)
        allow(user).to receive(:role).and_return('not admin')

        expect(wiki.can_modify_wiki?(user)).to eq(false)
      end
    end
  end

end
  

