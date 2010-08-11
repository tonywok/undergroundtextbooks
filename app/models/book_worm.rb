require 'nokogiri'
require 'open-uri'

class BookWorm
  API_URL = "http://isbndb.com/api/books.xml"
  API_KEY = "2I9YKZ6J"

  def self.crawl(book)
    doc = Nokogiri::XML(open("#{API_URL}?access_key=#{API_KEY}&index1=isbn&value1=#{book.isbn}"))
    doc.xpath("//BookData//Title").first.children.to_s
  end

end
