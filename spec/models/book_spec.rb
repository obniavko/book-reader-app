require 'rails_helper'

RSpec.describe Book, type: :model do
  let!(:book) { create(:book, :with_attached_cover, :with_attached_content) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:isbn) }

  it { is_expected.to validate_length_of(:title).is_at_least(1).is_at_most(150) }
  it { is_expected.to validate_length_of(:author).is_at_least(1).is_at_most(50) }
  it { is_expected.to validate_length_of(:description).is_at_most(1000) }

  it { is_expected.to validate_uniqueness_of(:isbn).case_insensitive }

  it { is_expected.to have_one_attached(:cover) }
  it { is_expected.to have_one_attached(:content) }
end
