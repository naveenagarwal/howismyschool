class AddSchoolIdToSchoolBranch < ActiveRecord::Migration
  def change
    add_reference :school_branches, :school, index: true
  end
end
