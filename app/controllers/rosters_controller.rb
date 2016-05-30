class RostersController < ApplicationController

  def list
    @courses = ScheduledCourse.unscoped.public_send(params[:type]).paginate(:page => params[:page], :per_page => 20)
  end

end
