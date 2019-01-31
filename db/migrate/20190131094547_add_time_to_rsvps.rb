class AddTimeToRsvps < ActiveRecord::Migration[5.1]
  def change
    add_column :rsvps, :rsvp_time, :time, null: false, default: "14:00"
  end
end
