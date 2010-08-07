class Book < ActiveRecord::Base

  ISBN10_REGEX = /^(?:\d[\ |-]?){9}[\d|X]$/
  ISBN13_REGEX = /^(?:\d[\ |-]?){13}$/

  validates_presence_of :title, :isbn

  belongs_to :user

  attr_accessor :title, :isbn, :condition, :available, :need

  scope :needed_and_available, lambda { |book| where(book.need? && book.available?) }

  def have?
    !need?
  end

end
