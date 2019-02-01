module RsvpHelper

  def free_spots(date)
    40 - Rsvp.where("rsvp_date = ?", date.strftime("%Y-%m-%d 00:00:00")).count
  end

  def spots_for_next(weekday = "Tue")
    40 - Rsvp.where("rsvp_date = ?", next_weekday(weekdays.index weekday).strftime("%Y-%m-%d 00:00:00")).sum(:pax)
  end

  # method to return the date of the next weekday to happen using the position of the weekday [Sun, 0] [Mon, 1] [Tue, 2] [Wed, 3], etc.
  def next_weekday(weekday = 2)
    date = Date.today
    unless date.strftime("%w") == weekday.to_s
      date += 1 + ((weekday -1 -date.wday) % 7)
    end
    date
  end

private
  def weekdays
    ["Sun","Mon","Tue","Wed","Thu", "Fri", "Sat"]
  end
end
