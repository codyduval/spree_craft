Given /^custom shipment associated with order R100$/ do
  order = Order.find_by_number('R100')
  FactoryGirl.create(:shipment, :order => order)
end

Given /^custom inventory units associated with order R100$/ do
  order = Order.find_by_number('R100')
  FactoryGirl.create(:inventory_unit, :order => order)
end
