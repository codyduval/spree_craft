require 'spec_helper'

describe CheckoutController do
  before(:each) do
    request.env["rack.url_scheme"] = "https"
  end
  let(:user) { FactoryGirl.create(:user) }
  let(:order) { FactoryGirl.create(:order) }
  before do
   controller.stub :current_order => order, :current_user => user
  end

  pending "should understand checkout routes" do
    assert_routing("/checkout/delivery", {:controller => "checkout", :action => "edit", :state => "delivery"})
    assert_routing({ :method => 'put', :path => "/checkout/delivery" }, {:controller => "checkout", :action => "update", :state => "delivery"})
  end

  context "#edit" do

    it "should redirect to the cart path unless checkout_allowed?" do
      order.stub :checkout_allowed? => false
      get :edit, { :state => "delivery" }
      response.should redirect_to cart_path
    end

    it "should redirect to the cart path if current_order is nil" do
      controller.stub(:current_order).and_return(nil)
      get :edit, { :state => "delivery" }
      response.should redirect_to cart_path
    end

    it "should redirect to cart if order is completed" do
      order.stub(:completed? => true)
      get :edit, {:state => "address"}
      response.should redirect_to(cart_path)
    end

  end

  context "#update" do

    context "save successful" do
      before do
        order.stub(:update_attribute).and_return true
      end

      it "should assign order" do
        post :update, {:state => "confirm"}
        assigns[:order].should_not be_nil
      end

    end

    context "save unsuccessful" do

      it "should assign order" do
        post :update, {:state => "confirm"}
        assigns[:order].should_not be_nil
      end

      it "should not change the order state" do
        order.should_not_receive(:update_attribute)
        post :update, { :state => 'confirm' }
      end


    end

    context "when current_order is nil" do
      before { controller.stub :current_order => nil }
      it "should not change the state if order is completed" do
        order.should_not_receive(:update_attribute)
        post :update, {:state => "confirm"}
      end

      it "should redirect to the cart_path" do
        post :update, {:state => "confirm"}
        response.should redirect_to cart_path
      end
    end

    context "Spree::GatewayError" do

      before do
        order.stub(:update_attributes).and_raise(Spree::GatewayError)
        post :update, {:state => "whatever"}
      end

    end

  end

end
