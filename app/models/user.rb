class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :books

  def library
    books.collect {|book| book.have? }
  end

  def wish_list
    books.collect {|book| book.need? }
  end

  def find_accomplices
    Book.needed_and_available
  end

end

