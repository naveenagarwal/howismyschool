class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :title, index: true
      t.references :creator, polymorphic: true, index: true
      t.references :school_branch, index: true
      t.hstore :event_for, default: {}
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
    add_index :schedules, :start_time
    add_index :schedules, :end_time
  end
end
