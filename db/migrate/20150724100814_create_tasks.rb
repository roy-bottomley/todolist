class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description, null: false, default: ''
      t.integer :priority, null: false, default: 0
      t.date :due_date
      t.boolean :completed, null: false, default: false
      t.integer :status, null: false, default: 0
      t.belongs_to :task_list, null: false

      t.timestamps
    end
  end
end
