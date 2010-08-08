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
      user.has_these_books.include?(Book.find_by_isbn("1934356549")).should be_true
    end
  end

  def create_book(options = default_book_copy)
    post(:create, { :book => { :title => "#{options[:title]}", 
                               :isbn  => "#{options[:isbn]}",
                               :copy_attributes => { :need      => "#{options[:need]}",
                                                     :available => "#{options[:available]}" }}})
  end

  def default_book_copy
    { :title     => "Agile Web Development with Rails",
      :isbn      => "1934356549", 
      :need      => false, 
      :available => true }
  end
end
