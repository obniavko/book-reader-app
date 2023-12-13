class BooksController < ApplicationController
  def index
    @books = collection
  end

  def show
    @book = resource
  end

  def new
    @book = Book.new
  end

  def edit
    @book = resource
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to book_path(@book), notice: "Book was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @book = resource

    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Book was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    resource.destroy

    redirect_to books_path, notice: 'Book was successfully destroyed.',
      status: :see_other
  end

  def search
    if search_params[:query].present?
      @books = BooksIndex.query(query_string: {fields: [:title, :author, :isbn],
      query: search_params[:query], default_operator: 'and'}).records

      flash.now[:notice] = @books.any? ? "Found #{@books.count} books" : "No books match your search."
    else
     flash.now[:notice] = "Please, enter your search parameters."
    end

   render :index
  end

  private

    def book_params
      params.require(:book).permit(:title, :author, :isbn, :description, :cover, :content)
    end

    def search_params
      params.require(:search).permit(:query)
    end

    def collection
      Book.ordered
    end

    def resource
      collection.find(params[:id])
    end
end
