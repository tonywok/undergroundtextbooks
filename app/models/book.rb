class Book < ActiveRecord::Base

  ISBN10_REGEX = /^(?:\d[\ |-]?){9}[\d|X]$/
  ISBN13_REGEX = /^(?:\d[\ |-]?){13}$/

  validates_presence_of :title, :isbn

  has_many :copies
  has_many :users, :through => :copies

  accepts_nested_attributes_for :copies

  def unavailable_copies
    copies.reject { |copy| copy.available? }
  end

  def available_copies
    copies.select { |copy| copy.available? }
  end

  def copies_needed
    copies.select { |copy| copy.need? }
  end

  def copies_had
    copies.reject { |copy| copy.need? }
  end
end
