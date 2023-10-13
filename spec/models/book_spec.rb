require 'rails_helper'

RSpec.describe Book, type: :model do
  it {is_expected.to validate_presence_of(:title) }
  it {is_expected.to validate_presence_of(:author) }
  it {is_expected.to validate_presence_of(:description) }
  it {is_expected.to validate_uniqueness_of(:isbn) }
  it {is_expected.to validate_length_of(:title).is_at_most(150) }
  it {is_expected.to validate_length_of(:description).is_at_most(1000) }
  it {is_expected.to allow_value("978-3-16-148410-0").for(:isbn) }
end
