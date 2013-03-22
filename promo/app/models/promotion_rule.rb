# Base class for all promotion rules
class PromotionRule < ActiveRecord::Base
  belongs_to :promotion, :foreign_key => 'activator_id'

  #attr_accessible :type

  scope :of_type, lambda {|t| {:conditions => {:type => t}}}

  def eligible?(order, options = {})
    raise 'eligible? should be implemented in a sub-class of Promotion::PromotionRule'
  end

  private
  
  def self.attributes_protected_by_default
    super - ['type']
  end
end
