class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :copies
  has_many :books, :through => :copies

  scope :all_except, lambda { |me| where("users.id != ?", me) }

  def has_these_books
    copies.collect do |copy|
      copy.book if !copy.need? and copy.available?
    end.uniq
  end

  def needs_these_books
    copies.collect do |copy|
      copy.book if copy.need? and copy.available?
    end.uniq
  end

  def find_accomplices
    accomplices = User.all_except(self).inject([]) do |bros, dude|
      offered_books = dude.needs_these_books & has_these_books
      needed_books  = needs_these_books & dude.has_these_books
      bros << dude unless offered_books.empty? or needed_books.empty?
    end  
  end

  def list_potential_trades(accomplice)
    [i_have(accomplice), they_have(accomplice)]
  end

  def i_have(accomplice)
    accomplice.needs_these_books & has_these_books
  end

  def they_have(accomplice)
    needs_these_books & accomplice.has_these_books
  end

  def sort_accomplices_by(accomplices, decision = "i_have")
    accomplices.sort do |cohort_one, cohort_two|
      cohort_two.send(:decision).size <=> cohort_one.send(:decision).size
    end
  end

end

