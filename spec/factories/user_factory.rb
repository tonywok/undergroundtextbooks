Factory.sequence :email do |n|
  "person#{n}@example.com" 
end

Factory.define :user do |u|
  u.name                      "Test User"
  u.email                     Factory.next(:email)
  u.password                  "password"
  u.password_confirmation     "password"
end


Factory.define :luke, :class => :user do |u|
  u.name                      "Luke Skywalker"
  u.email                     Factory.next(:email)
  u.password                  "password"
  u.password_confirmation     "password"
  u.books {|book| [ book.association(:book_luke_needs),
                    book.association(:book_luke_has) ] }
end

Factory.define :book_luke_needs, :class => :book do |b|
  b.title       "Agile Web Development with Rails"
  b.isbn        "1934356549"
  b.condition   "okay"
  b.available   true
  b.need        true
end

Factory.define :book_luke_has, :class => :book do |b|
  b.title       "Programming Ruby 1.9"
  b.isbn        "1934356085"
  b.condition   "okay"
  b.available   true 
  b.need        false
end

Factory.define :leia, :class => :user do |u|
  u.name                      "Leia Organa"
  u.email                     Factory.next(:email)
  u.password                  "password"
  u.password_confirmation     "password"
  u.books {|book| [ book.association(:book_leia_needs),
                    book.association(:book_leia_has) ] }
end

Factory.define :book_leia_needs, :class => :book do |b|
  b.title       "Programming Ruby 1.9"
  b.isbn        "1934356085"
  b.condition   "okay"
  b.available   true 
  b.need        true
end

Factory.define :book_leia_has, :class => :book do |b|
  b.title       "Agile Web Development with Rails"
  b.isbn        "1934356549"
  b.condition   "okay"
  b.available   true     
  b.need        false
end
