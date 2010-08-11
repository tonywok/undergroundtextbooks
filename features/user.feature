Feature: User
  In order to trade a book
  As a book owner
  I Want other users to be able to find my book
Background:
  Given I am logged in

Scenario: I want to add a book to my library
  Given My book exists in the system
  And I am at my library page
  When I add a book
  Then I am given a copy of that book
  And I am redirected back to my library

Scenario: I have a book to trade
  Given I have a copy of a book that Tony needs
  And Tony has a copy of a book that I need
  When I ask the system to find my potential trades
  Then Tony should be in my search results

Scenario: I have potential trades
  Given I tell the system to find trades
  And It finds a list of potential users to trade with
  When I choose a user to trade with
  Then I am taken to their trade page
  And I am presented with our books of interest

Scenario: Submitting a trade proposal
  Given I am on Mitch's trade page.
  And I am presented with our books of interest
  When I check a book of his that I want
  And I check a book of mine I'm willing to give up
  And I click submit trade proposal
  Then I should be redirected back to my library
  And I should have a pending trade proposal with Mitch
