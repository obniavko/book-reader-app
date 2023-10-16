require 'rails_helper'

RSpec.describe "/books", type: :request do
  let(:valid_attributes) {{
    title: "MyString",
    author: "MyString",
    isbn: "978-3-16-148410-0",
    description: "MyText"
  }}

  let(:invalid_attributes) {{
    title: "",
    author: "",
    isbn: "abc!3-16_14410.0",
    description: ""
  }}

  let(:new_attributes) {{
    title: "NewString",
    author: "NewString",
    isbn: "978-3-16-148410-1",
    description: "NewText"
  }}

  describe "GET /index" do
    it "renders a successful response" do
      Book.create! valid_attributes
      get books_url

      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      book = Book.create! valid_attributes
      get book_url(book)

      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_book_url

      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      book = Book.create! valid_attributes
      get edit_book_url(book)

      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Book and redirects to it" do
        expect {
          post books_url, params: { book: valid_attributes }
        }.to change(Book, :count).by(1)

        expect(response).to redirect_to(book_url(Book.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Book and renders a response with 422 status" do
        expect {
          post books_url, params: { book: invalid_attributes }
        }.to change(Book, :count).by(0)

        expect(response).to be_unprocessable
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do

      it "updates the requested book and redirects to it" do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: new_attributes }
        book.reload

        new_attributes.each_pair do |key, value|
          expect(book[key]).to eq(value)
        end

        expect(response).to redirect_to(book_url(book))
      end
    end

    context "with invalid parameters" do

      it "renders a response with 422 status" do
        book = Book.create! valid_attributes
        patch book_url(book), params: { book: invalid_attributes }

        expect(response).to be_unprocessable
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested book and redirects to the books list" do
      book = Book.create! valid_attributes

      expect {
        delete book_url(book)
      }.to change(Book, :count).by(-1)

      expect(response).to redirect_to(books_url)
    end
  end
end
