Factory.sequence :email do |n|
  "person#{n}@example.com" 
end

Factory.define :user do |u|
  u.name                    "Test User"
  u.email                   Factory.next(:email)
  u.password                "password"
  u.password_confirmation   "password"
end


Factory.define :book_owner, :class => :user do |u|
  u.name                    "Test User"
  u.email                   Factory.next(:email)
  u.password                "password"
  u.password_confirmation   "password"
end
