class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.datetime :date
      t.references :user, null: false, foreign_key: true
      t.references :daddy_service, null: false, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
