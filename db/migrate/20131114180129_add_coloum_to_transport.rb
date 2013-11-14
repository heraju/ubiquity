class AddColoumToTransport < ActiveRecord::Migration
  def change
    add_column :transports, :lat, :float
    add_column :transports, :long, :float
  end
end
