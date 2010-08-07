require 'spec_helper'

describe User do
  describe "I have a book." do
    before :each do
      User.delete_all
    end

    it "should create a personal copy of my book." do
      user = Factory.create(:user)
      book = Factory.create(:book)
      book.copies.create(:user => user)
      user.books.include?(book).should be_true
    end

    it "should allow me to set my copy as unavailable." do
      user = Factory.create(:user)
      book = Factory.create(:book)
      copy = book.copies.create(:user => user)
      copy.update_attributes(:available => false)
      book.unavailable_copies.include?(copy).should be_true
    end

    it "should be set to available automatically." do
      user = Factory.create(:user)
      book = Factory.create(:book)
      copy = book.copies.create(:user => user)
      book.available_copies.include?(copy).should be_true
    end
  end
end
