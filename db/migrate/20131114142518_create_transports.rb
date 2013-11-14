class CreateTransports < ActiveRecord::Migration
  def change
    create_table :transports do |t|
      t.integer :transport_type_id
      t.text :session
      t.integer :user_id
      t.string :number

      t.timestamps
    end
  end
end
