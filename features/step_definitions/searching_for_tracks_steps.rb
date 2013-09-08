Before do
  @aruba_timeout_seconds = 10
end

Given(/^some "(.*?)" tracks exist in SoundCloud$/) do |artist|

end

When(/^I search using the term "(.*?)"$/) do |search_term|
  run_simple(unescape("sc search nineinchnails -t"), false)
end

Then(/^I should see the following track information:$/) do |table|
  table.hashes.each do |h|
    h.keys.each do |key|
      assert_partial_output(h[key], all_output)
    end
  end
end