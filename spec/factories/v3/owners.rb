# frozen_string_literal: true

FactoryBot.define do
  factory :v3_owner, class: Hubspot::V3::Owner do
    skip_create

    id { rand(100_000..999_999).to_s }
    email { Faker::Internet.email }
    type { 'PERSON' }
    firstName { Faker::Name.first_name }
    lastName { Faker::Name.last_name }
    userId { rand(100_000..999_999) }
    userIdIncludingInactive { userId }
    createdAt { Time.current.iso8601 }
    updatedAt { Time.current.iso8601 }
    archived { false }
    active { true }

    initialize_with { Hubspot::V3::Owner.new(attributes.stringify_keys) }
  end
end
