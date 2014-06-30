require 'spec_helper'

module Prosperity
  describe DashboardGraphsController, type: :controller do
    routes { Prosperity::Engine.routes }

    let(:valid_graph_attributes) do
      { title: "My Graph", period: "month", graph_type: 'line' }
    end

    let!(:valid_dashboard_attributes) do
      { title: "My Dashboard", default: false }
    end

    let(:graph) { Graph.create!(valid_graph_attributes) }
    let(:dashboard) { Dashboard.create!(valid_dashboard_attributes) }
    let(:dashboard_graph) { DashboardGraph.create! graph: graph, dashboard: dashboard }

    describe "POST 'create'" do
      it "associates a graph an a dashboard" do
        expect do 
          post :create, dashboard_id: dashboard.id, graph_id: graph.id
        end.to change(DashboardGraph, :count).by(1)
        dg = DashboardGraph.last
        expect(dg.graph).to eq(graph)
        expect(dg.dashboard).to eq(dashboard)
      end

      it "errors if you try to add the same graph twice" do
        post :create, dashboard_id: dashboard.id, graph_id: graph.id
        post :create, dashboard_id: dashboard.id, graph_id: graph.id
        expect(response).to redirect_to(edit_dashboard_path(dashboard))
        expect(flash[:error]).to be_present
      end
    end

    describe "DELETE 'destroy'" do
      it "deassociates a graph an a dashboard" do
        dashboard_graph
        expect do 
          delete :destroy, dashboard_id: dashboard.id, graph_id: graph.id
        end.to change(DashboardGraph, :count).by(-1)
      end

      it "404 when not found" do
        expect do 
          delete :destroy, dashboard_id: dashboard.id, graph_id: graph.id
        end.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
