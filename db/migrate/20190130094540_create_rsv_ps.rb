class CreateRsvPs < ActiveRecord::Migration[5.1]
  def change
    create_table :rsvps do |t|
      t.datetime :rsvp_date, null: false
      t.integer :pax, default: 1
      t.string :name, null: false
      t.string :telephone, null: false

      t.timestamp
    end
  end
end
