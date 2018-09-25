class AddIndexToCommitters < ActiveRecord::Migration[5.1]
  def change
    add_index :committers, [:stock, :place]
    add_index :committers, [:repo, :user, :place], unique: true
  end
end
