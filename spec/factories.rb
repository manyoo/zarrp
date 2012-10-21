FactoryGirl.define do
    factory :user do
        firstname    "test"
        lastname     "Huf" 
        gender       "male"
        default_currency "USD"
        date_of_birth 10.year.ago
        access_token "alskdjfalskd"
    end

    factory :event do
        name        "event1"
        address     "address1"
        club        "club"
        phone       "123435"
        short_desc  "short"
        desc        "desc"
        time        1.day.ago
        email       "test@example.com"
    end
end