class CreatePostImages < ActiveRecord::Migration[7.1]
  def change
    create_table :post_images do |t|
      t.references :post, null: false, foreign_key: true
      t.string :media_url
      t.integer :media_type

      t.timestamps
    end
  end
end
