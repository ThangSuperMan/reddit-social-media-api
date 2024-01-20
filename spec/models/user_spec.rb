require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }

  describe '#set_initial_role' do
    let(:user) { create(:user) }

    it 'set initial role to "user" before creating the record' do
      expect(user.role).to eq('user')
    end
  end
end
