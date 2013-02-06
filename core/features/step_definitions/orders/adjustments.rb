When /^I follow "New Adjustment" custom$/ do
  page.first('#content .toolbar .actions li a').click
end

Given /^an adjustment exists for order R100$/ do
  order = Order.find_by_number('R100')
  FactoryGirl.create(:adjustment, :order => order)
end
