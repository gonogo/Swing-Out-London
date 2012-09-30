module PageHelper

  # Switching h1 and h2 in the header
  def heading_hn(action, *args, &block)
    if action == "index" then
      hn = :h1
    else
      hn = :h2
    end
    
    content_tag hn, *args, &block
  end
  
  # Links for navigation
  def nav_link(name, *args)
    # Render the link...
    link_to_unless_current(name, *args) do 
      # ...but if the page was current, render a span instead
      content_tag :span, name, :class => "current"
    end 
  end
  
  # Display a link to validate the markup of the page
  def valid_statement(page)
    validator_address = "http://validator.w3.org/check?uri=referer"
    
    # Different pages may or may not validate depending on use of external namespaces, so this needs to be reflected in the link:
    if page=="index"
      return "#{link_to "Almost valid XHTML", validator_address} (#{link_to "blame Facebook & Twitter", :action => "about", :anchor => "validation_failures"})"
    else
      return link_to "Valid XHTML", validator_address
    end
  end
  
  def display_tweet(tweet)
    if tweet
      # tweet is a Hashie::Mash, so acts like an object
      created_date_string = tweet.created_at.to_s(:timepart) + " on " + tweet.created_at.to_s(:short_date)
  
      raw tweet.text.twitterify + " " + link_to(created_date_string, "#{TWITTER_URL}/status/#{tweet.id}", :class => "tweet_created")
    else
      raw "Sorry, for some reason we can't load the latest tweet. Please visit the " + 
        link_to("Swing Out London Twitter feed", "#{TWITTER_URL}", :title => "Swing Out London on Twitter")
    end
  end
  
  
end
