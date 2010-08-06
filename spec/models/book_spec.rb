require 'spec_helper'

describe Book do
  describe "a valid book" do
    it "should be able to be valid" do
      @book = Factory.create(:book).should be_valid
    end
    
    it "should accept isbn-10" do
      @book = Factory.create(:book, :isbn => 1934356085).should be_valid
    end

    # TODO
    # it "should accept isbn-13" do
    #   @book = Factory.create(:book, :isbn => 978-1934356081).should be_valid
    # end
  
    it "should be owned by a user" do
      @book = Factory.create(:book)
      @book.user.should exist
    end
  end
end
