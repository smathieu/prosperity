require_dependency "prosperity/application_controller"

module Prosperity
  class DashboardGraphsController < ApplicationController
    before_action :get_objs
    def create
      dashboard_graph = DashboardGraph.new(graph: @graph, dashboard: @dashboard)

      unless dashboard_graph.save
        set_error(dashboard_graph)
      end
      redirect_to edit_dashboard_path(@dashboard)
    end

    def destroy
      dashboard_graph = DashboardGraph.where(graph_id: @graph.id, dashboard_id: @dashboard.id).first
      raise ActiveRecord::RecordNotFound unless dashboard_graph
      dashboard_graph.destroy
      redirect_to edit_dashboard_path(@dashboard)  
    end

    private
    def get_objs
      @graph = Graph.find(params[:graph_id])
      @dashboard = Dashboard.find(params[:dashboard_id])
    end
  end
end
