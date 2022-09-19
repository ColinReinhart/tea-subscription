require 'rails_helper'

RSpec.describe Customer,type: :model do
  describe 'relationships' do
    it { should have_many(:subscriptions)}
    it { should have_many(:teas).through(:subscriptions)}
  end

  describe 'validations' do
    it { should validate_presence of(:first_name)}
    it { should validate_presence of(:last_name)}
    it { should validate_presence of(:email)}
    it { should validate_presence of(:address)}
  end
end
