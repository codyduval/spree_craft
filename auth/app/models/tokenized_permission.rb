class TokenizedPermission < ActiveRecord::Base
  attr_accessible :token
  belongs_to :permissable, :polymorphic => true
end