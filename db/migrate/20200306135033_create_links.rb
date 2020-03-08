class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.integer :user_id
      t.string :link
      t.string :link_descrition
      t.timestamps
    end
  end
end
