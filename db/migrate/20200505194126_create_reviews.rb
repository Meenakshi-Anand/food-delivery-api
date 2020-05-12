class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.belongs_to :order
      t.text :description,null:false
      t.timestamps
    end
  end
end
