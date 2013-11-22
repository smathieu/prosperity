require 'spec_helper'

module Prosperity
  describe MetricsController do
    routes { Prosperity::Engine.routes }
    
    describe "GET index" do
      it "returns successfully" do
        get :index
        response.should be_success
      end
    end

    describe "GET show" do
      it "returns a metric" do
        get :show, id: 'UsersMetric'
        response.should be_success
        assigns(:metric).should be_a(Metric)
      end
    end
  end
end
