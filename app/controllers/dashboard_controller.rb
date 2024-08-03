class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def trigger_sample_job
    SampleJob.perform_later
  end
end
