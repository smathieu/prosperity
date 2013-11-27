require 'spec_helper'

module Prosperity
  describe DashboardsController do
    routes { Prosperity::Engine.routes }

    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        response.should be_success
      end
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', id: '1'
        response.should be_success
      end
    end

    describe "GET 'new'" do
      it "returns http success" do
        get 'new'
        response.should be_success
      end
    end

    describe "POST 'create'" do
      it "creates a new dashboard" do
        expect do
          post 'create', dashboard: {title: 'test'}
        end.to change(Dashboard, :count).by(1)
        response.should redirect_to(action: :index)
      end

      it "should handle validation error" do
        post 'create', dashboard: {title: ''}
        response.status.should == 200
        flash[:error].should be_present
      end
    end
  end
end
