require 'anemone'

urls = [
  "http://www.amazon.co.jp/gp/bestsellers/books/",
  "http://www.amazon.co.jp/gp/bestsellers/digitall-text/2275256051"
]

options = {
  depth_limit: 1,
  skip_query_strings: true,
  proxy_host: 'localhost',
  proxy_port: '5432',
}

Anemone.crawl(urls,options) do |anemone|

  anemone.focus_crawl do |page|
    page.links.keep_if do |link|
      link.to_s.match(/\/gp\/bestsellers\/books|\/gp\/bestsellers\/digital-text/)
    end
  end

  PATTERN = /466298\/+|466282\/+|2291657051\/+|2291905051\/+/
  anemone.on_pages_like(PATTERN) do |page|
    puts page.url
  end
end
