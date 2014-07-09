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
        begin
          search = current_teacher.searches.where(text: params[:q]).first || current_teacher.searches.new
          search.text = params[:q]
          search.school_branch_id = current_school_branch.id
          search.save

          @query = Sunspot.search [Student, ClassTest] do
            data_accessor_for(Student).include = [:class_room]
            data_accessor_for(ClassTest).include = [:test_results]

            fulltext params[:q] do
              minimum_match 1
            end

            order_by :score, :desc
            with :school_branch_id, current_school_branch.id
          end

          @results = @query.results

          response.headers["x-search-term"] = params[:q]
        rescue Exception => e
          byebug
          @results = []
          set_flash_messages type: "error", message: "Error in Searching... Please try after some time"
        end
      }
    end
  end

end
