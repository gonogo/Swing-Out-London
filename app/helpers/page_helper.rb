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
  
  def tweet_message
    if @latest_tweet.nil?
      "Sorry, for some reason we can't load the latest tweet. Please visit the " + 
      link_to("Swing Out London Twitter feed", "http://www.twitter.com/swingoutlondon", :title => "Swing Out London on Twitter")
    else
      created_date = Time.zone.parse(@latest_tweet.created_at)
      created_date_string = created_date.to_s(:timepart) + " on " + created_date.to_s(:short_date)
      @latest_tweet.text.twitterify + " " + link_to(created_date_string, "http://www.twitter.com/swingoutlondon/#{@latest_tweet.id_str}", :class => "tweet_created")
    end
  end
  
end
