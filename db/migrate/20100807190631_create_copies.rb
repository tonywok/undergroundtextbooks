class CreateCopies < ActiveRecord::Migration
  def self.up
    create_table :copies do |t|
      t.integer :user_id
      t.integer :book_id
      t.boolean :need, :default => false
      t.boolean :available, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :copies
  end
end
