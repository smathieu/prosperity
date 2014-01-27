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
  end
end
