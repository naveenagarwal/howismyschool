class AddDetailsToSchoolController < ActiveRecord::Migration
  def change
    add_reference :school_controllers, :school_branch, index: true
  end
end
