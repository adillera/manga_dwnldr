class CreateMangaSites < ActiveRecord::Migration
  def change
    create_table :manga_sites do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
