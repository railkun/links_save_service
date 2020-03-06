class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.integer :link_id
      t.string :tag

      t.timestamps
    end
  end
end
