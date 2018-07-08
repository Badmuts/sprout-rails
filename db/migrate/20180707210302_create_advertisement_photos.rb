class CreateAdvertisementPhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :advertisement_photos do |t|
      t.references :advertisement, foreign_key: true
      t.attachment :photo
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
