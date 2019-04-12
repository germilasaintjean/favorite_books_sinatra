class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :genre
      t.integer :user_id
    end
  end
end
