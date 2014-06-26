class AddManagerToSchoolController < ActiveRecord::Migration
  def change
    add_reference :school_controllers, :manager, index: true
  end
end
