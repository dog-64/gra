class RenameUserToAuthorInCommitters < ActiveRecord::Migration[5.1]
  def change
    rename_column :committers, :user, :author
  end
end
