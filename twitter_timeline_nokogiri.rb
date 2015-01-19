require 'nokogiri'
require 'open-uri'

doc = Nokogiri.HTML(open('https://twitter.com/TwitterJP'))
doc.xpath("//div[@data-component-term='tweet']").each do |tweet|
  # Tweet時間
  puts Time.at(tweet.xpath(
    ".//a[@class='ProfileTweet-timestamp js-permalink js-nav js-tooltip']/span"
  ).first['data-time'].to_i)

  # Tweet本文
  puts tweet.xpath(
    ".//p[@class='ProfileTweet-text js-tweet-text u-dir']"
  ).text

  # Retweet数
  retweet = tweet.xpath(
    ".//div[@class='ProfileTweet-action ProfileTweet-action--retweet js-toggleState js-toggleRt']/button[@class='ProfileTweet-actionButton  js-actionButton js-actionRetweet js-tooltip']"
  )
  if !retweet.empty?
    puts "Retweetされた数: #{retweet.first.xpath(".//span[@class='ProfileTweet-actionCountForPresentation']").first.content}"
  end

  # お気に入りされた数
  like = tweet.xpath(
    ".//div[@class='ProfileTweet-action ProfileTweet-action--favorite js-toggleState']/button[@class='ProfileTweet-actionButton js-actionButton js-actionFavorite js-tooltip']"
  )
  if !like.empty?
    puts "お気に入りされた数: #{like.first.xpath(".//span[@class='ProfileTweet-actionCountForPresentation']").first.content}"
  end
  
end
