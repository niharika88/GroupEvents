FactoryGirl.define do
  factory :groupevent do
    name        { Faker::Lorem.words(5) }
    description { Faker::Lorem.sentence(20) }
    location    { Faker::Address.city << ', ' << Faker::Address.street_address << ' ' << Faker::Address.secondary_address }
    start_date  { Faker::Date.between(Date.today, Date.today + 7.days) }
    end_date    { Faker::Date.between(Date.today + 10.days, Date.today + 60.days) }
    duration     3
  end
end