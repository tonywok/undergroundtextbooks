class Book
  include Mongoid::Document
  field       :title
  field       :condition       
  field       :isbn
  field       :edition,  :type => Integer
  field       :rating,   :type => Float  
  embeds_one  :user

  validates_presence_of     :title, :isbn
  validates_numericality_of :edition,
                              :allow_nil => true
  validates_numericality_of :rating, :only_integer => false, 
                              :allow_nil => true
  validates_inclusion_of    :condition, :in => ["awesome", "meh", "shitty"],
                              :allow_nil => true
  validates_format_of       :isbn, :with => /^(?:\d[\ |-]?){9}[\d|X]$/
  
end
