require 'spec_helper'

describe Book do
  describe "validation" do
    it "should have a title" do
      @book = Factory.create(:book_i_have)
      @book.should be_valid

    end
  end
end
