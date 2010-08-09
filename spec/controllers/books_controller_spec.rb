require 'spec_helper'

describe BooksController do
  describe "when I want to add a book I have," do

    let(:user) { Factory.create(:user) }
    
    before :each do
      request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    it "should find or create the book and create a personal copy." do
      get(:new)
      response.should be_success
      create_book
      user.has_these_books.include?(Book.find_by_isbn("1934356085")).should be_true
      # response.should render_template('decide_where_it_should_go')
    end
  end

  def create_book(options = default_book_copy)
    post(:create, :book => 
                  { :id    => "#{options['id']}",
                    :title => "#{options['title']}", 
                    :isbn  => "#{options['isbn']}",
                    :copies_attributes => 
                    { "0" => { :need      => "#{options['need']}",
                               :available => "#{options['available']}" }}})
  end

  def default_book_copy
    Factory.create(:book).attributes.update({'need' => 'false', 'available' => 'true' })
  end
end
