class BooksController < ApplicationController
  
  before_filter :require_login, :only=>[:new, :create]
  
  def new
    @users = User.find(:all)
    @user = current_user
    if @book.nil?
      @book = Book.new()      
    end
  end
  
  def create
    asin = params[:asin] || params[:book][:asin]
    @book = AmazonCatalog.asinLookup(asin)  	
  	#check if the book exists (by isbn)
    if(Book.find_by_asin(@book.asin).nil?)  	
  		#try to save it, and render an error if it doesn't work
  		if(!@book.save)
  			flash[:error] = "There was an error saving your book.\n" + @book.errors.full_messages.join(",")
        @users = User.find(:all)
        render :controller => :books, :action => :new
        return  			
  		end
    else		

      if(!@book.eql?(Book.find_by_asin(@book.asin)))
        Book.find_by_asin(@book.asin).update_from_amazon(@book)        
      end
		  #retrieve the existing book from the database
      @book = Book.find_by_asin(@book.asin)    	
  	end
  	
    @library_record = LibraryRecord.new
    @library_record.book_id = @book.id
    @library_record.user_id = @current_user.id
    @library_record.status = "Available"

    @library_record.save
                
    redirect_to users_path, :flash => {:notice => "Book added!"}

    
  end
    
  def newBooksSearch
    title = params[:title]
    author = params[:author]
    isbn = params[:isbn]
    
    if(isbn.nil? || isbn.empty?)      
      @books = AmazonCatalog.searchBooks(title, author, params[:page])
      if @books == nil
        @books = Array.new
      end
    else
      puts "performing book lookup, isbn: " + isbn
      @books = AmazonCatalog.lookupBook(isbn)
    end
    
    render :partial => "searchResults"
  end  

  def get_remove_modal
      book = Book.find(params[:bookId])
      render :partial => "remove_book_modal" , :locals => {:book => book, :user => @current_user}     
  end

  def remove
      books = User.find_by_id(params[:userId]).books
      books.each do |b|
        if b.id = params[:bookId]
          books.delete(b)
        end
      end

      render :partial => "remove_book_saved"
  end

  # Added 7/28/12 by alex
  def index
    @book = Book.find_by_asin(params[:id]) || AmazonCatalog.asinLookup(params[:id])
  end

  def show
    @book = Book.find_by_id(params[:id]) # no security issue here right?
    @copies = @book.users
  end
  
end
