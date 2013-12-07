require_dependency "prosperity/application_controller"

module Prosperity
  class GraphsController < ApplicationController
    def new
      @graph = Graph.new
    end

    def edit
    end

    def update
      
    end

    def create
      @graph = Graph.new
      [:title, :period, :option].each do |attr|
        @graph.send("#{attr}=", params.fetch(:graph, {})[attr])
      end

      if @graph.save
        redirect_to edit_graph_path(@graph)
      else
        flash[:error] = @graph.errors.full_messages.to_sentence
        render action: :new
      end
    end
  end
end
