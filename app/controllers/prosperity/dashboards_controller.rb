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
      dashboard
    end

    def edit
      dashboard
    end

    def create
      @dashboard = Dashboard.new
      @dashboard.title = params.fetch(:dashboard, {})[:title]
      @dashboard.default = false
      if @dashboard.save
        redirect_to edit_dashboard_path(@dashboard)
      else
        flash[:error] = @dashboard.errors.full_messages.to_sentence
        render action: :new
      end
    end

    def destroy
      dashboard.destroy
      redirect_to action: 'index'
    end

    private

    def dashboard
      @dashboard ||= Dashboard.find(params[:id])
    end
  end
end
