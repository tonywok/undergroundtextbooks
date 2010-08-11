require 'spec_helper'
require 'book_worm'

describe BookWorm do
  context "When querying for a book." do
    let(:book) { Factory.create(:book) }

    it "should be able to search by isbn" do
      results = BookWorm.search(:isbn, '1934356085')
      results.first.isbn.should == "1934356085"
    end

    it "should be able to search by title" do
      results = BookWorm.search(:title, 'Ruby')
      results.each do |book|
        return true if book.title == "Programming Ruby 1.9"
      end.should be_true
    end
  end
end
