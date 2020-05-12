class CreateWorkingHours < ActiveRecord::Migration[5.2]
  def change
    create_table :working_hours do |t|
      t.date :day, null:false, unique:true
      t.time :start_time, null:false
      t.time :end_time, null:false
      t.integer :status, null:false, default:0
      t.belongs_to :restaurant
    end
    add_index :working_hours, :day, unique:true
  end
end
