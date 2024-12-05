class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :rating
      t.references :user, null: false, foreign_key: true
      t.references :daddy_service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
