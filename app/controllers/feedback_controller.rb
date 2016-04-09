require "pry"

class FeedbackController < ApplicationController
  def new
    @feedback = Feedback.new
  end
  
  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.request = request
    if @feedback.deliver
      flash.now[:notice] = 'Thank you for your feedback.  We will review your
                            message and try to improve our website soon.'
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end
end