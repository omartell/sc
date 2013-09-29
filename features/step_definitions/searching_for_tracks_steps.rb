Before do
  @aruba_timeout_seconds = 3
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

Given(/^I have the short soundcloud track name "(.*?)"$/) do |track_name|

end

When(/^I run play permalink with "(.*?)"$/) do |track_name|
  run_simple(unescape("sc play #{track_name} --permalink"), false)
end

Then(/^I should see the following now playing track information:$/) do |table|
  assert_partial_output("Now playing", all_output)
  table.hashes.each do |h|
    h.keys.each do |key|
      assert_partial_output(h[key], all_output)
    end
  end
end

Given(/^I have the soundcloud track id for "(.*?)"$/) do |arg1|

end

When(/^I run play id with "(.*?)"$/) do |track_id|
  run_simple(unescape("sc play #{track_id} --id"), false)
end
