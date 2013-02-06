FactoryGirl.define do 
  factory :promotion, :class => Promotion, :parent => :activator do
    f.name 'Promo'
  end
end
