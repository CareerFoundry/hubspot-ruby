
FactoryBot.define do
  factory :contact, class: Hubspot::Contact do
    to_create { |instance| instance.save }

    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
  end
end
