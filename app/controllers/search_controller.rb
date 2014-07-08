class SearchController < ApplicationController
  def index
    respond_to do |format|
      format.js {
        render nothing: true
      }
    end
  end

  def show
    respond_to do |format|
      format.js {
        render nothing: true
      }
    end
  end

  def create
    respond_to do |format|
      format.js {
        render nothing: true
      }
    end
  end

end
