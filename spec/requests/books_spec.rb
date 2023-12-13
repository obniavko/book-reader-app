require 'rails_helper'

RSpec.describe BooksController, type: :request do
  let!(:book) { create(:book) }
  let(:valid_params) { attributes_for(:book) }
  let(:invalid_params) { attributes_for(:book, :empty_title) }
  let(:new_params) { attributes_for(:book, :new_title) }

  describe "GET #index" do
    it "renders a successful response" do
      get books_path

      expect(response).to be_successful
      expect(CGI.unescapeHTML(response.body)).to include(book.title)
    end
  end

  describe "GET #show" do
    it "renders a successful response" do
      get book_path(book)

      expect(response).to be_successful
      expect(CGI.unescapeHTML(response.body)).to include(book.title)
    end
  end

  describe "GET #new" do
    it "renders a successful response" do
      get new_book_path

      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "renders a successful response" do
      get edit_book_path(book)

      expect(response).to be_successful
      expect(CGI.unescapeHTML(response.body)).to include(book.title)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Book and redirects to it" do
        expect do
          post books_path, params: { book: valid_params }
        end.to change(Book, :count).by(1)

        expect(response).to be_redirect
        expect(flash[:notice]).to eq("Book was successfully created.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Book and renders a response with 422 status" do
        expect do
          post books_path, params: { book: invalid_params }
        end.not_to change(Book, :count)

        expect(response).to be_unprocessable
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do

      it "updates the requested book and redirects to it" do
        expect do
          patch book_path(book), params: { book: new_params }
          book.reload
        end.to change { book.title }.to(new_params[:title])

        expect(response).to be_redirect
        expect(flash[:notice]).to eq("Book was successfully updated.")
      end
    end

    context "with invalid parameters" do

      it "renders a response with 422 status" do
        patch book_path(book), params: { book: invalid_params }

        expect(response).to be_unprocessable
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested book and redirects to the books list" do
      expect { delete book_path(book) }.to change(Book, :count).by(-1)
      expect(response).to be_redirect
      expect(flash[:notice]).to eq("Book was successfully destroyed.")
    end
  end

  describe "GET #search" do
    context "when query is not blank and has correct values" do
      before do
        allow(BooksIndex).to receive_message_chain(:query, :records).and_return([book])
        get search_books_path, params: { search: { query: "Title" } }
      end

      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "returns the books in the response body" do
        expect(response.body).to include(book.title)
      end

      it "has a flash message for 1 book" do
        expect(flash.now[:notice]).to eq("Found 1 books")
      end
    end

    context "when query is not blank and has incorrect values" do
      before do
        allow(BooksIndex).to receive_message_chain(:query, :records).and_return([])
        get search_books_path, params: { search: { query: "Unknown_title" } }
      end

      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "not return any books" do
        expect(response.body).not_to include
      end

      it "gets a message that the book was not found" do
        expect(flash.now[:notice]).to eq("No books match your search.")
      end
    end

    context "when query is blank" do
      before do
        get search_books_path, params: { search: { query: " " } }
      end

      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "has a flash message" do
        expect(flash.now[:notice]).to eq("Please, enter your search parameters.")
      end
    end
  end
end
