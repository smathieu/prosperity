require_dependency "prosperity/application_controller"

module Prosperity
  class DashboardsController < ApplicationController
    def index
      @dashboards = Dashboard.all
    end

    def new
      @dashboard = Dashboard.new
    end

    def show
      @dashboard = Dashboard.find(params[:id])
    end

    def edit
      @dashboard = Dashboard.find(params[:id])
    end

    def create
      @dashboard = Dashboard.new
      @dashboard.title = params.fetch(:dashboard, {})[:title]
      @dashboard.default = false
      if @dashboard.save
        redirect_to action: :index
      else
        flash[:error] = @dashboard.errors.full_messages.to_sentence
        render action: :new
      end
    end
  end
end
