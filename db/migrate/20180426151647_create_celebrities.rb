class CreateCelebrities < ActiveRecord::Migration[5.1]
  def change
    create_table :celebrities do |t|
      t.string :name, null: false
      t.string :photoUrl, null: false
      t.string :profileUrl, null: false
      t.references :media
      t.timestamps
    end
  end
end
