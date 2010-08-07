class Copy < ActiveRecord::Base
  attr_accessor :available, :need
  belongs_to :book
  belongs_to :user
end
