class SearchController < ApplicationController
  before_action :authenticate_teacher!

  def index
    @searches = Paginate.get_records(
        relation_object: current_teacher.searches,
        page: params[:page],
        per_page: params[:per_page]
      )

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

        search = current_teacher.searches.new
        search.searcher = current_teacher
        search.text = params[:q]

        query = Sunspot.search [Student] do
          fulltext params[:q]
          order_by :score, :desc
          with :school_branch_id, current_school_branch.id
          paginate page: params[:page] || DEFAULT_PAGE, per_page: params[:per_page] || DEFAULT_PER_PAGE
        end

        @results = query.results
        search.result = @results
        search.save
      }
    end
  end

end
