require 'spec_helper'

describe User do
  describe "When I let the system know I have a copy of a book," do

    let(:user) { Factory.create(:user) }
    let(:book) { Factory.create(:book) }
    let(:ruby_book) { Factory.create(:ruby_book) }
    let(:rails_book) { Factory.create(:rails_book) }
    let(:copy) { book.copies.create(:user => user) }
    before { copy }

    it "should create a personal copy of my book." do
      user.books.include?(book).should be_true
    end

    it "should allow me to set my copy as unavailable." do
      copy.update_attributes(:available => false)
      book.unavailable_copies.include?(copy).should be_true
    end

    it "should be set to available automatically." do
      book.available_copies.include?(copy).should be_true
    end

    it "should know that I have a copy of the book." do
      book.copies_had.include?(copy).should be_true
    end

    it "should allow me to specify that I need a copy." do
      copy.update_attributes(:need => true)
      book.copies_needed.include?(copy).should be_true
    end

    it "should be able to find all the books I have." do 
      ruby_book.copies.create(:user => user)
      user.has_these_books.include?(ruby_book).should be_true 
    end

    it "should be able to find all the books I need." do
      rails_book.copies.create(:user => user, :need => true)
      user.needs_these_books.include?(rails_book).should be_true 
    end
  end

  context "I have a book someone else needs and they have a book I need." do
    
    let(:user) { Factory.create(:user) }
    let(:luke) { Factory.create(:luke) }
    let(:leia) { Factory.create(:leia) }
    let(:ruby_book) { Factory.create(:ruby_book) }
    let(:rails_book) { Factory.create(:rails_book) }

    before :each do
      ruby_book.copies.create(:user => luke, :need => false)
      rails_book.copies.create(:user => luke, :need => true)
      ruby_book.copies.create(:user => leia, :need => true)
      rails_book.copies.create(:user => leia, :need => false)
    end

    it "should find potential trades between me and another user." do
      i_have, they_have = luke.list_potential_trades(leia)
      i_have.include?(ruby_book).should be_true
      they_have.include?(rails_book).should be_true
      i_have.include?(rails_book).should be_false
      they_have.include?(ruby_book).should be_false
    end

    it "should be able to find all other users to see if we can trade." do
      User.all_except(user).include?(user).should be_false
      User.all_except(user).include?(leia).should be_true
      User.all_except(user).include?(luke).should be_true
    end

    it "should pair me with such a person." do
      leia.find_accomplices.include?(luke).should be_true
      luke.find_accomplices.include?(leia).should be_true
    end

  end
end
