class ZoneMember < ActiveRecord::Base
  belongs_to :zone
  belongs_to :zoneable, :polymorphic => true

  attr_accessible :zoneable, :zone

  def name
    return nil if zoneable.nil?
    zoneable.name
  end

end