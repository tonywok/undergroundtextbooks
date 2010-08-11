require 'spec_helper'

describe BookWorm do
  context "When querying for a book." do
    let(:book) { Factory.create(:book) }

    it "should pull back information about a book" do
      book_info = BookWorm.crawl(book).should == "Programming Ruby 1.9"
    end
  end
end
