require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::GeneralSettingsController do
  before(:each) do
    request.env["rack.url_scheme"] = "https"
  end

  before :each do 

    controller.stub :current_user => mock_model(User, :has_role? => true)
  end

  it "saves dismissed alerts in a preference" do
    Spree::Config.set :dismissed_spree_alerts => "1"
    xhr :post, :dismiss_alert, :alert_id => 2
    response.response_code.should == 200
    Spree::Config[:dismissed_spree_alerts].should eq "1,2"
  end

end


