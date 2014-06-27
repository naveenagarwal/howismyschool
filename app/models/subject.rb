class Subject < ActiveRecord::Base
  belongs_to :school_branch
  belongs_to :creator, polymorphic: true

  class << self
    def get_subjects_array_for_select_option(school_branch_id: nil)
      select(:id, :name).
      where(
          school_branch_id: school_branch_id
        ).
      map { |p| [ p.name, p.id ] }
    end
  end

end
