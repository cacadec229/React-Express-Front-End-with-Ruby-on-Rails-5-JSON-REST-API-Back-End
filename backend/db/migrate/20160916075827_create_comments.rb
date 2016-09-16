class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :author
      t.text :text

      t.timestamps
    end
  end
end
