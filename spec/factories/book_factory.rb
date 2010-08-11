Factory.define :ruby_book, :class => :book do |b|
  b.title       "Programming Ruby 1.9"
  b.isbn        "1934356085"
end

Factory.define :book do |b|
  b.title       "Programming Ruby 1.9"
  b.isbn        "1934356085"
end

Factory.define :rails_book, :class => :book do |b|
  b.title       "Agile Web Development with Rails"
  b.isbn        "1934356549"
end
