# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  x = page.body.to_s
  # puts x
  indexOfe1 = x.index(e1)
  indexOfe2 = x.index(e2)
  
  assert(indexOfe1<indexOfe2, "Not sorted correctly")
  
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
  theRatings = rating_list.split(", ")
  theR = Movie.all_ratings
  
  within "#ratings_form" do
        theRatings.each do |rating|
          if uncheck
            uncheck "ratings[#{rating}]"
          else
            
            check "ratings[#{rating}]"
          end
        end
        
        theR.each do |r|
          if(theRatings.include?(r) == false)
            uncheck "ratings[#{r}]"
          end
        end
      
  end
  # find(:css, "#cityID[]").set(true)
  # page.at_css("[class='Event_CategoryTree category']")
      # all("input[type='checkbox']").each { |ch| uncheck ch[:id] }
      # x = find("ratings_#{rating}")
    # x = find("ratings_#{rat}")
  
  
  # flunk "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  value = Movie.all.length
  
  l = page.all("table#movies tr").count - 1
  #the titles of the table are also being included so need to subtract those
  
  assert(l==value, "number of rows in table don't match total DB entries")
end
