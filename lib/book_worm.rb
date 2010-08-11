require 'httparty'
require 'cgi'

module BookWorm
  include HTTParty
  format :xml
  base_uri 'http://isbndb.com'

  QUERY_BASE = "/api/books.xml?access_key=2I9YKZ6J"

  def self.search(index1, value1)
    books = get(QUERY_BASE + "&index1=#{index1}&value1=#{CGI::escape(value1)}")
    books = [books['ISBNdb']['BookList']['BookData']].flatten.collect do |book|
      Book.new(:title     => book["Title"],
               :publisher => book["PublisherText"], 
               :author    => book["AuthorsText"],
               :isbn      => book["isbn"], 
               :isbn13    => book["isbn13"])
    end
  end
end
