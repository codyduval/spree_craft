class Spree::BaseController < ActionController::Base
  include SpreeBase
  include ::SslRequirement

  ssl_allowed :all
end
