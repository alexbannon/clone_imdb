class AddBirthdayToCelebrities < ActiveRecord::Migration[5.1]
  def change
    add_column :celebrities, :birth_month, :integer
    add_column :celebrities, :birth_day, :integer
  end
end
