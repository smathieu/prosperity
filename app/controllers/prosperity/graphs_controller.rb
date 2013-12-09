require_dependency "prosperity/application_controller"

module Prosperity
  class GraphsController < ApplicationController
    before_action :get_graph, only: [:edit, :update]
    def new
      @graph = Graph.new
    end

    def edit
    end

    def update
    end

    def create
      @graph = Graph.new
      [:title, :period].each do |attr|
        @graph.send("#{attr}=", params.fetch(:graph, {})[attr])
      end

      if @graph.save
        redirect_to edit_graph_path(@graph)
      else
        flash[:error] = @graph.errors.full_messages.to_sentence
        render action: :new
      end
    end
    
    private

    def get_graph
      @graph = Graph.find(params[:id])
    end
  end
end
