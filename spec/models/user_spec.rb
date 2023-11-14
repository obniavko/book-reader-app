require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }

  it { is_expected.to allow_value("user@gmail.com").for(:email) }
  it { is_expected.not_to allow_value("user@gmailcom").for(:email) }

  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
end
