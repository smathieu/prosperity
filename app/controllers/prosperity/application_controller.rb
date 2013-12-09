module Prosperity
  class ApplicationController < ActionController::Base
    protected
    def set_error(model)
      flash[:error] = model.errors.full_messages.to_sentence
    end


    def strong_params?
      defined?(ActionController::StrongParameters)
    end
  end
end
