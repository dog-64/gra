class CreateCommiters < ActiveRecord::Migration[5.1]
  def change
    create_table :committers do |t|
      t.string :repo
      t.string :user, limit: 39
      t.integer :total, unsigned: true
      t.integer :place, unsigned: true
      t.integer :stock, unsigned: true

      t.timestamps
    end
  end
end
