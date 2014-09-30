class CreateMangas < ActiveRecord::Migration
  def change
    create_table :mangas do |t|
      t.references :manga_site, index: true
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
