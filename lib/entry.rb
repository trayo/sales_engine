class Entry
  attr_reader :regdate,
              :first_name,
              :last_name,
              :email_address,
              :phone_number,
              :street,
              :city,
              :state,
              :zipcode

  def initialize(data)
    @regdate = data[:regdate]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @email_address = data[:email_address]
    @phone_number = data[:homephone]
    @street = data[:street]
    @city = data[:city]
    @state = data[:state]
    @zipcode = data[:zipcode]
  end

  def name
    "#{first_name} #{last_name}"
  end
end
