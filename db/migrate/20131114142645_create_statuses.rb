class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.integer :statusable_id
      t.string :statusable_type

      t.timestamps
    end
  end
end
