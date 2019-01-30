require "rails_helper"

RSpec.describe Rsvp, :type => :model do
  context "when making a reservation" do
    it "only allows to reserve for Tuesdays or Wednesdays" do
      rsvp = Rsvp.new rsvp_date: "14/01/2019", name: "Someone Hungry", pax: 2, telephone: "123456432"
      expect(rsvp.save).to eq(false)
      rsvp.rsvp_date = "15/01/2019"
      expect(rsvp.save).to eq(true)
      rsvp.rsvp_date = "16/01/2019"
      expect(rsvp.save).to eq(true)
    end

    it "does not allow to reserve without a name" do
      rsvp = Rsvp.new rsvp_date: "15/01/2019", name: "Someone Hungry", pax: 2, telephone: "123456432"
      rsvp.name = nil
      expect(rsvp.save).to eq(false)
    end

    it "does not allow to reserve without a telephone" do
      rsvp = Rsvp.new rsvp_date: "15/01/2019", name: "Someone Hungry", pax: 2, telephone: "123456432"
      rsvp.telephone = nil
      expect(rsvp.save).to eq(false)
    end

    it "does not allow to reserve without a pax" do
      rsvp = Rsvp.new rsvp_date: "15/01/2019", name: "Someone Hungry", pax: 2, telephone: "123456432"
      rsvp.pax = nil
      expect(rsvp.save).to eq(false)
    end

    it "does not allow to reserve without a valid (integer) pax" do
      rsvp = Rsvp.new rsvp_date: "15/01/2019", name: "Someone Hungry", pax: 2, telephone: "123456432"
      rsvp.pax = "test"
      expect(rsvp.save).to eq(false)
      rsvp.pax = 2.2
      expect(rsvp.save).to eq(false)
      rsvp.pax = 5
      expect(rsvp.save).to eq(true)
    end
  end
end
