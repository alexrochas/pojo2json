
input = """
  private BookingChangeCanceledEvent(
        Long bookingId,
        Long driverId,
        DateTime dateBookingCreated,
        BookingOfferType bookingOfferType,
        Boolean pooling,
        Boolean myTaxiNow,
        Boolean followUp,
        Boolean autoAccepted,
        Boolean onMyWay,
        Long pickupTime)
    {
        super(
            bookingId,
            driverId,
            BookingState.CANCELED,
            dateBookingCreated,
            bookingOfferType,
            pooling,
            myTaxiNow,
            followUp,
            autoAccepted,
            onMyWay,
            pickupTime);
    }"""


/(?<access>private|public)\s*(?<className>\w*)\s*(?:\((?<attributes>.*?)\))/m =~ input
puts "parsed access #{access} for className #{className}"

def defaultValue(type) 
  case type
    when /string/i
      ""
    when /int/i
      0
    when /char/i
      ""
    when /long/i
      0
    when /bool/i
      true
    when /date/i
      Time.now
  end
end

require 'json'

json = attributes
  .delete("\n")
  .split(",")
  .map { |s| s.strip }
  .map { |s| 
    /\s*(?<type>\w*)\s(?<name>\w*)/ =~ s 
    [name, defaultValue(type)]
  }
  .to_h

puts(JSON.pretty_generate(json))


