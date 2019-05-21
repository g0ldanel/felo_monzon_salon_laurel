class Rsvp < ApplicationRecord
  validate :rsvps_can_only_be_wed_thu, on: [:create, :update]
  validates :pax, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true
  validates :telephone, presence: true, length: {in: 9..15}

  # def rsvp_date
  #   self[:rsvp_date].strftime("%d/%m/%Y")
  # end

private

  def rsvps_can_only_be_wed_thu #rsvps only admited for Tuesdays and Wednesdays
    if !(self.rsvp_date.strftime("%a") == "Thu" || self.rsvp_date.strftime("%a") == "Wed")
      self.errors.add(:rsvp_date, "Sólo se admiten reservas Miércoles y Jueves")
    end
  end

end
