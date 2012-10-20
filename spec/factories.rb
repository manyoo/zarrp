FactoryGirl.define do
    factory :user do
        name        "test"
        email       "test@example.com"
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