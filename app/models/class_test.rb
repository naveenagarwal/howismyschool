class ClassTest < ActiveRecord::Base
  belongs_to :school
  belongs_to :school_branch
  belongs_to :creator, polymorphic: true
  belongs_to :document

  validates :name, presence: true, uniqueness: { scope: :school_branch_id }

  class << self
    def get_class_tests_array_for_select_option(school_branch_id: nil)
      select(:id, :name).
      where(
          school_branch_id: school_branch_id
        ).
      map { |p| [ p.name, p.id ] }
    end
  end

end
