Given /^the custom orders exist for reports feature$/ do
  order = FactoryGirl.create(:order)
  order.update_attributes_without_callbacks({:adjustment_total => 100})
  order.completed_at = Time.now
  order.save!

  order = FactoryGirl.create(:order)
  order.update_attributes_without_callbacks({:adjustment_total => 200})
  order.completed_at = Time.now
  order.save!

  order = FactoryGirl.create(:order)
  order.update_attributes_without_callbacks({:adjustment_total => 200})
  order.completed_at = 3.years.ago
  order.created_at = 3.years.ago
  order.save!

  order = FactoryGirl.create(:order)
  order.update_attributes_without_callbacks({:adjustment_total => 200})
  order.completed_at = 3.years.from_now
  order.created_at = 3.years.from_now
  order.save!
end
