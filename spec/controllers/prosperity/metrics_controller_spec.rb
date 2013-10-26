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
  end
end
