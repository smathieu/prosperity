module Prosperity
  class ApplicationController < ActionController::Base
    protected
    def set_error(model)
      flash[:error] = model.errors.full_messages.to_sentence
    end

    def render_json_error(msg, code)
      render json: {error: msg}, status: code
    end

    def strong_params?
      defined?(ActionController::StrongParameters)
    end

    def now
      @now ||= Time.now
    end

    def period
      params.fetch(:period, 'week')
    end

    def end_time 
      params[:end_time].present? ? Time.parse(params[:end_time].to_s) : now
    end

    def start_time
      params[:start_time].present? ? Time.parse(params[:start_time].to_s) : end_time - 3.months
    end

    helper_method :end_time, :start_time, :period
  end
end
