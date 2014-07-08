class Search < ActiveRecord::Base
  belongs_to :searcher, polymorphic: true
  belongs_to :school_branch
end
