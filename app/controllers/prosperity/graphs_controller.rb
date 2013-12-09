require_dependency "prosperity/application_controller"

module Prosperity
  class GraphsController < ApplicationController
    before_action :get_graph, only: [:edit, :update, :show]
    def new
      @graph = Graph.new
    end

    def edit
      @graph.graph_lines.build
    end

    def show
      end_time = Time.now
      start_time = end_time - 1.year

      render json: {
        title: @graph.title,
        extractors: @graph.graph_lines.map do |line|
          {
            key: line.extractor,
            url: data_metric_path(id: line.metric, 
                                  extractor: line.extractor, 
                                  option: line.option, 
                                  period: @graph.period, 
                                  start_time: start_time, 
                                  end_time: end_time),
          }
        end
      }
    end

    def update
      unless @graph.update_attributes graph_params
        set_error(@graph)
      end
      redirect_to action: :edit
    end

    def create
      @graph = Graph.new
      [:title, :period].each do |attr|
        @graph.send("#{attr}=", graph_params[attr])
      end

      if @graph.save
        redirect_to edit_graph_path(@graph)
      else
        set_error(@graph)
        render action: :new
      end
    end
    
    private

    def get_graph
      @graph = Graph.find(params[:id])
    end

    def graph_params
      if strong_params?
        params.require(:graph).
          permit(Graph::ATTR_ACCESSIBLE + [:graph_lines_attributes => GraphLine::ATTR_ACCESSIBLE])
      else
        params.fetch(:graph, {})     
      end
    end
  end
end
