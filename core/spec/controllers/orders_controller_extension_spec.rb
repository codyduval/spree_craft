require 'spec_helper'

describe OrdersController do

  before do
    controller.stub :current_user => FactoryGirl.create(:user)
  end

  context "extension testing" do
    context "update" do

      context "render" do
        before do
          @order = FactoryGirl.create(:order)
          OrdersController.instance_eval do
            respond_override({:update => {:html => {:success => lambda { render(:text => 'success!!!') }}}})
            respond_override({:update => {:html => {:failure => lambda { render(:text => 'failure!!!') }}}})
          end
        end
        describe "POST" do
          it "has value success" do
            put :update, {}, {:order_id => @order.id}
            response.should be_success
            assert (response.body =~ /success!!!/)
          end
        end
      end

      context "redirect" do
        before do
          @order = FactoryGirl.create(:order)
          OrdersController.instance_eval do
            respond_override({:update => {:html => {:success => lambda { redirect_to(Order.first) }}}})
            respond_override({:update => {:html => {:failure => lambda { render(:text => 'failure!!!') }}}})
          end
        end
        describe "POST" do
          it "has value success" do
            put :update, {}, {:order_id => @order.id}
            response.should be_redirect
          end
        end
      end

      context "validation error" do
        before do
          @order = FactoryGirl.create(:order)
          Order.update_all("state='address'")
          OrdersController.instance_eval do
            respond_override({:update => {:html => {:success => lambda { render(:text => 'success!!!') }}}})
            respond_override({:update => {:html => {:failure => lambda { render(:text => 'failure!!!') }}}})
          end
        end
        describe "POST" do
          it "has value success" do
            put :update, {:order => {:email => ''}}, {:order_id => @order.id}
            response.should be_success
            assert (response.body =~ /failure!!!/)
          end
        end
      end

    end
  end

end
