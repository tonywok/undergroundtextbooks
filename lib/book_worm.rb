require 'httparty'
require 'cgi'

module BookWorm
  include HTTParty
  format :xml
  base_uri 'http://isbndb.com'

  QUERY_BASE = "/api/books.xml?access_key=2I9YKZ6J"

  # possible index/value pairs:
  #   isbn     - pass in a valid isbn or isbn13 value.
  #   title    - keyword search on title, long title and latinized title.
  #   combined - search across titles, authors, and publisher name
  #   full     - search across itles, authors, publisher name, summary, 
  #              notes, awards information, etc
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
