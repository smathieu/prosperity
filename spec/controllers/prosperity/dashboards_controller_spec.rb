require 'spec_helper'

module Prosperity
  describe DashboardsController, type: :controller do
    let!(:dashboard) { Dashboard.create! title: "My Dashboard", default: false }
    routes { Prosperity::Engine.routes }

    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        expect(response).to be_success
        expect(assigns(:dashboards)).to be_present
      end
    end

    describe "GET 'show'" do
      it "returns http success" do
        get 'show', id: dashboard.id
        expect(response).to be_success
        expect(assigns(:dashboard)).to eq(dashboard)
      end
    end

    describe "GET 'edit'" do
      it "returns http success" do
        get 'edit', id: dashboard.id
        expect(response).to be_success
        expect(assigns(:dashboard)).to eq(dashboard)
      end
    end

    describe "GET 'new'" do
      it "returns http success" do
        get 'new'
        expect(response).to be_success
      end
    end

    describe "POST 'create'" do
      it "creates a new dashboard" do
        expect do
          post 'create', dashboard: {title: 'test'}
        end.to change(Dashboard, :count).by(1)
        dashboard = assigns(:dashboard)
        expect(dashboard).to be_a(Dashboard)
        expect(response).to redirect_to(edit_dashboard_path(dashboard))
      end

      it "should handle validation error" do
        post 'create', dashboard: {title: ''}
        expect(response.status).to eq(200)
        expect(flash[:error]).to be_present
      end
    end

    describe "DELETE 'destroy'" do
      it "deleted the dashboard" do
        delete 'destroy', id: dashboard.id
        expect(response).to redirect_to(dashboards_path)

        expect(Dashboard.find_by(id: dashboard.id)).to be_nil
      end
    end
  end
end
