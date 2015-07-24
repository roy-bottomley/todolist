class CreateTaskLists < ActiveRecord::Migration
  def change
    create_table :task_lists do |t|
      t.string :name, null: false, default: ''
      t.integer :priority, null: false, default: 0
      t.belongs_to :user
      t.timestamps
    end
  end
end
