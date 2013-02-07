class PromotionActionLineItem < ActiveRecord::Base

  belongs_to :promotion_action, :class_name => 'Promotion::Actions::CreateLineItems'
  belongs_to :variant

  attr_accessible :variant, :quantity, :variant_id

end
