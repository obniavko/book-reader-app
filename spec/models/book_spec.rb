require 'rails_helper'

RSpec.describe Book, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_length_of(:title).is_at_most(150) }
  it { is_expected.to validate_length_of(:description).is_at_most(1000) }
  it { is_expected.to allow_value("978-3-16-148410-0").for(:isbn) }
  it { is_expected.not_to allow_value("").for(:title) }
  it { is_expected.not_to allow_value("").for(:author) }
  it { is_expected.not_to allow_value("isbn").for(:isbn) }

  describe "uniqueness" do
    subject { FactoryBot.create(:book) }

    it { is_expected.to validate_uniqueness_of(:isbn).case_insensitive }
  end
end
