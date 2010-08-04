require 'spec_helper'

describe Book do
  it "should be able to be valid" do
    @book = Factory.create(:book).should be_valid
  end
end
