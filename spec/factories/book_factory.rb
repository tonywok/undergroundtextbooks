Factory.define :book_i_need, :class => :book do |b|
  b.title       "Programming Ruby 1.9"
  b.isbn        "1934356085"
  b.condition   "okay"
  b.available   true
  b.need        true
end

Factory.define :book_i_have, :class => :book do |b|
  b.title       "Programming Ruby 1.9"
  b.isbn        "1934356085"
  b.condition   "okay"
  b.available   true 
  b.need        false
end
