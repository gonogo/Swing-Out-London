Date::DATE_FORMATS[:default] = "%d/%m/%Y"

# TODO: REMOVE
Date::DATE_FORMATS[:uk_date] = "%d/%m/%Y"
Date::DATE_FORMATS[:uk_datetime] = "%d/%m/%Y %H:%M"
#END REMOVE

Date::DATE_FORMATS[:timepart] = "%H:%M"
Date::DATE_FORMATS[:short_date] = lambda { |date| date.strftime("#{date.day.ordinalize} %b") }
Date::DATE_FORMATS[:listing_date]= lambda { |date| date.strftime("%A #{date.day.ordinalize} %B") }

#ADD?
Time::DATE_FORMATS[:default] = "%d/%m/%Y %H:%M"
# TODO: REMOVE
Time::DATE_FORMATS[:uk_date] = "%d/%m/%Y"
Time::DATE_FORMATS[:uk_datetime] = "%d/%m/%Y %H:%M"
#END REMOVE

Time::DATE_FORMATS[:timepart] = "%H:%M"
Time::DATE_FORMATS[:short_date] = lambda { |date| date.strftime("#{date.day.ordinalize} %b") }
Time::DATE_FORMATS[:listing_date]= lambda { |date| date.strftime("%A #{date.day.ordinalize} %B") }