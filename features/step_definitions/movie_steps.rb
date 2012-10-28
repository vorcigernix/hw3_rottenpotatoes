# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
   Movie.create(movie)
  end
  #flunk "Unimplemented"
end



When /^I submit the search form$/ do
  click_button "Refresh"
end

Then /^I should see all of the movies$/ do
assert page.has_css?("table tbody tr", count: Movie.all.count)

end




# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  assert page.body.index(e1) < page.body.index(e2)
  #flunk "Unimplemented"

end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
 rating_list.split.each{|r|
    if uncheck
      uncheck("ratings_#{r}")
    else
      check("ratings_#{r}")
    end
}
end
Then /^I should see only PG and R movies$/ do
#assert page.all('td', :text => 'PG-13').count == 0 
 assert page.has_xpath?("//td[text()='PG']") && page.has_xpath?("//td[text()='R']") && page.has_no_xpath?("//td[text()='PG-13']") && page.has_no_xpath?("//td[text()='G']") && page.has_no_xpath?("//td[text()='NC-17']")

end
