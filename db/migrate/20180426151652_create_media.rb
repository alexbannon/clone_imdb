class CreateMedia < ActiveRecord::Migration[5.1]
  def change
    create_table :media do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.decimal :rating, default: 0
      t.string :director, null: false
      t.timestamps
    end
  end
end
