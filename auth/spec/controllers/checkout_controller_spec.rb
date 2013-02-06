require 'spec_helper'

describe CheckoutController do
  before(:each) do
    request.env["rack.url_scheme"] = "https"
  end
  let(:order) { Order.new }
  let(:user) { mock_model User, :pending_promotions => [] }
  let(:token) { "some_token" }

  before do
    order.stub :checkout_allowed? => true, :user => user, :new_record? => false
    controller.stub :current_order => order
    controller.stub :current_user => nil
  end


  context "#edit" do
    context "when registration step enabled" do
      before do
        controller.stub :check_authorization
        Spree::Auth::Config.set(:registration_step => true)
      end

      context "when authenticated as registered user" do
        before { controller.stub :current_user => user }

        it "should proceed to the first checkout step" do
          get :edit, { :state => "address" }
          response.should render_template :edit
        end
      end

      context "when authenticated as guest" do
        before { controller.stub :auth_user => user }

        it "should redirect to registration step" do
          get :edit, { :state => "address" }
          response.should redirect_to checkout_registration_path
        end
      end

    end

    context "when registration step disabled" do
      before do
        Spree::Auth::Config.set(:registration_step => false)
        controller.stub :check_authorization
      end

      context "when authenticated as registered" do
        before { controller.stub :current_user => user }

        it "should proceed to the first checkout step" do
          get :edit, { :state => "address" }
          response.should render_template :edit
        end
      end

      context "when authenticated as guest" do
        before { controller.stub :auth_user => user }

        it "should proceed to the first checkout step" do
          get :edit, { :state => "address" }
          response.should render_template :edit
        end
      end

    end

    it "should check if the user is authorized for :edit" do
      controller.should_receive(:authorize!).with(:edit, order, token)
      get :edit, { :state => "address" }, { :access_token => token }
    end

  end


  context "#update" do

    it "should check if the user is authorized for :edit" do
      controller.should_receive(:authorize!).with(:edit, order, token)
      post :update, { :state => "address" }, { :access_token => token }
    end

  end

  context "#registration" do

    it "should not check registration" do
      controller.stub :check_authorization
      controller.should_not_receive :check_registration
      get :registration
    end

    it "should check if the user is authorized for :edit" do
      controller.should_receive(:authorize!).with(:edit, order, token)
      get :registration, {}, { :access_token => token }
    end

  end

  context "#update_registration" do
    let(:user) { user = mock_model User, :pending_promotions => [] }

    it "should not check registration" do
      controller.stub :check_authorization
      order.stub :update_attributes => true
      controller.should_not_receive :check_registration
      put :update_registration
    end

    it "should render the registration view if unable to save" do
      controller.stub :check_authorization
      order.should_receive(:update_attributes).with("email" => "invalid").and_return false
      put :update_registration, { :order => {:email => "invalid"} }
      response.should render_template :registration
    end

    it "should redirect to the checkout_path after saving" do
      order.stub :update_attributes => true
      controller.stub :check_authorization
      put :update_registration, { :order => {:email => "jobs@railsdog.com"} }
      response.should redirect_to checkout_path
    end

    it "should check if the user is authorized for :edit" do
      order.stub :update_attributes => true
      controller.should_receive(:authorize!).with(:edit, order, token)
      put :update_registration, { :order => {:email => "jobs@railsdog.com"} }, { :access_token => token }
    end

  end

end
