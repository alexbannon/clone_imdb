class ChangeColumnNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :celebrities, :photoUrl, :photo_url
    rename_column :celebrities, :profileUrl, :profile_url
    change_column :media, :rating, :float
  end
end
