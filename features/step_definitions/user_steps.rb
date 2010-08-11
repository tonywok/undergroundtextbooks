Given /^I am logged in$/ do 
  login
end

Given /^I own a (.*)$/ do |book|
  @book = Factory.create(:book)
  copy = Factory.create(:copy)#finish, create copy with book and user
  #the add that copy to the user's copy
end

When /^I add my book to the system$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^other users should be able to find my book$/ do
  pending # express the regexp above with the code you wish you had
end

def login
  @user = Factory.create(:user)
end
