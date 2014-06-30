class DrawChartController < ApplicationController
  before_action :ensure_session_exists!

  include Charts::BarChart

end
