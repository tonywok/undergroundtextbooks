require 'spec_helper'

describe User do
  describe "I have a book" do

    it "should add it to my library" do 
      user = Factory.build(:user)
      user.books << Factory.create(:book_i_have)
      user.library.size.should == 1
    end

  end

  describe "I want a book" do
    
    it "should be added to my wish list" do
      user = Factory.build(:user)
      user.books << Factory.create(:book_i_need)
      user.wish_list.size.should == 1
    end

  end

  describe "when I search for a book I need" do 
    describe "if I have a book someone else needs" do

      it "should pair us up" do
        luke = Factory.build(:luke)
        leia = Factory.build(:leia)
        luke.find_accomplices.include?(leia).should be_true
        leia.find_accomplices.include?(luke).should be_true
      end

    end
  end
end
