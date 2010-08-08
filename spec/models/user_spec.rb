require 'spec_helper'

describe User do
  describe "I have a book." do
    before :each do
      @user = Factory.create(:user)
      @book = Factory.create(:book)
      @copy = @book.copies.create(:user => @user)
    end

    it "should create a personal copy of my book." do
      @user.books.include?(@book).should be_true
    end

    it "should allow me to set my copy as unavailable." do
      @copy.update_attributes(:available => false)
      @book.unavailable_copies.include?(@copy).should be_true
    end

    it "should be set to available automatically." do
      @book.available_copies.include?(@copy).should be_true
    end

  end

  describe "I need a book." do
    before :each do
      @user = Factory.create(:user)
      @book = Factory.create(:book)
      @copy = @book.copies.create(:user => @user)
    end

    it "should allow me to specify that I need a copy." do
      @copy.update_attributes(:need => true)
      @book.copies_needed.include?(@copy).should be_true
    end

    it "should allow me to specify I have a copy." do
      @book.copies_had.include?(@copy).should be_true
    end
  end

  describe "when looking through my books" do
    before :each do
      @user = Factory.create(:user)
    end

    it "should be able to find all the books I have" do 
      ruby_book  = Factory.create(:ruby_book)
      ruby_book.copies.create(:user => @user)
      @user.has_these_books.include?(ruby_book).should be_true 
    end

    it "should be able to find all the books I need" do
      rails_book = Factory.create(:rails_book)
      rails_book.copies.create(:user => @user, :need => true)
      @user.needs_these_books.include?(rails_book).should be_true 
    end

    it "should be able to find all other users." do
      leia = Factory.create(:leia)
      luke = Factory.create(:luke)
      User.all_except(@user).include?(@user).should be_false
      User.all_except(@user).include?(leia).should be_true
      User.all_except(@user).include?(luke).should be_true
    end
      
  end

  describe "I have a book someone else needs and they have a book I need" do
    before :each do
      @luke       = Factory.create(:luke)
      @leia       = Factory.create(:leia)
      @ruby_book  = Factory.create(:ruby_book)
      @rails_book = Factory.create(:rails_book)
      @ruby_book.copies.create(:user => @luke, :need => false)
      @rails_book.copies.create(:user => @luke, :need => true)
      @ruby_book.copies.create(:user => @leia, :need => true)
      @rails_book.copies.create(:user => @leia, :need => false)
    end

    it "should pair me with such a person" do
      @leia.find_accomplices.include?(@luke).should be_true
      @luke.find_accomplices.include?(@leia).should be_true
    end

    it "should find potential trades between you and another user" do
      i_have, they_have = @luke.list_potential_trades(@leia)
      i_have.include?(@ruby_book).should be_true
      they_have.include?(@rails_book).should be_true
      i_have.include?(@rails_book).should be_false
      they_have.include?(@ruby_book).should be_false
    end
    # describe "when sorting potential traders." do
    #   before :each do
    #     @luke       = Factory.create(:luke)
    #     @leia       = Factory.create(:leia)
    #     @ruby_book  = Factory.create(:ruby_book)
    #     @rails_book = Factory.create(:rails_book)
    #     @ruby_book.copies.create(:user => @luke, :need => false)
    #     @rails_book.copies.create(:user => @luke, :need => true)
    #     @ruby_book.copies.create(:user => @leia, :need => true)
    #     @rails_book.copies.create(:user => @leia, :need => false)
    #   end

    #   it "should be able to sort by things I can offer" do
    #      
    #   end

    #   it "should be able to sort by things they can offer me" do
    #     
    #   end

    # end
  end
end
