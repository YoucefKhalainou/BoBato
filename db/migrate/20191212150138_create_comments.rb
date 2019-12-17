class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
    	t.belongs_to :user, index: true
    	t.references :recipient, index: true
    	t.integer :rating
    	t.text :review
      t.timestamps
    end
  end
end
