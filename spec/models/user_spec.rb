
require 'spec_helper'

describe User do
  describe "a valid user" do
    it "should be able to be valid" do
      @book = Factory.create(:book)
      @book.user = Factory.build(:user)
    end
  end

  describe "a user owns books" do
    it "should own a book" do
      @book = Factory.create(:book)
      @book.build_user
    end
  end
end
