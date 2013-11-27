require_dependency "prosperity/application_controller"

module Prosperity
  class DashboardsController < ApplicationController
    def index
    end

    def new
      @dashboard = Dashboard.new
    end

    def edit
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
