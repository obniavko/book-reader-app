require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        title: "Title",
        author: "Author",
        isbn: "978-3-16-148410-0",
        description: "MyText"
      ),
      Book.create!(
        title: "Title",
        author: "Author",
        isbn: "978-3-16-148410-1",
        description: "MyText"
      )
    ])
  end

  it "renders a list of books" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Author".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("978-3-16-148410-0".to_s),
      count: 1
    assert_select cell_selector, text: Regexp.new("978-3-16-148410-1".to_s),
      count: 1
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
