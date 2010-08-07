class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string      :title
      t.string      :isbn
      t.string      :condition
      t.integer     :rating
      t.boolean     :available, :default => true 
      t.integer     :user_id
      t.boolean     :need, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
