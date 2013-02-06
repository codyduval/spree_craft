require 'spec_helper'

describe UsersController do
  before(:each) do
    request.env["rack.url_scheme"] = "https"
  end

  let(:admin_user) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  context "#create" do

    it "should create a new user" do
      post :create, {:user => {:email => "foobar@example.com", :password => "foobar123", :password_confirmation => "foobar123"} }
      assigns[:user].new_record?.should be_false
    end

    context "when an order exists in the session" do
      let(:order) { mock_model Order }
      before { controller.stub :current_order => order }

      it "should assign the user to the order" do
        order.should_receive(:associate_user!)
        post :create, {:user => {:email => "foobar@spreecommerce.com", :password => "foobar123", :password_confirmation => "foobar123"} }
      end
    end
  end

  context "#update" do
    context "when updating own account" do

      it "should perform update" do
        put :update, {:user => {:email => "mynew@email-address.com" } }
        assigns[:user].email.should == "mynew@email-address.com"
        response.should redirect_to(account_url)
      end
    end

    context "when attempting to update other account" do
      it "should not allow update" do
        put :update, {:user => FactoryGirl.create(:user)}, {:user => {:email => "mynew@email-address.com" } }
        response.should redirect_to(login_url)
      end
    end
  end

end
