class Book
  include Mongoid::Document
  field       :title
  field       :condition       
  field       :isbn
  field       :edition,  :type => Integer
  field       :rating,   :type => Float  

  validates_presence_of :title, :isbn
  validates_numericality_of :edition
  validates_numericality_of :rating, :only_integer => false
  validates_inclusion_of :condition, :in => ["awesome", "meh", "shitty"]
  
end
