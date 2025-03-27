# # frozen_string_literal: true

# require 'factory_bot'

# # Generate owners data using the V3 owner factory
# def generate_owners_data
#   owners = []
#   25.times do
#     owner = FactoryBot.build(:v3_owner)
#     owners << {
#       'id' => owner.properties['id'],
#       'email' => owner.properties['email'],
#       'type' => owner.properties['type'],
#       'firstName' => owner.properties['firstName'],
#       'lastName' => owner.properties['lastName'],
#       'userId' => owner.properties['userId'],
#       'createdAt' => owner.properties['createdAt'],
#       'updatedAt' => owner.properties['updatedAt'],
#       'archived' => owner.properties['archived']
#     }
#   end
#   { 'results' => owners }.to_json
# end

# # Load existing YAML file
# file = YAML.load_file('spec/fixtures/vcr_cassettes/v3/owners.yml')

# # Update only the response body
# file['http_interactions'].last['response']['body']['string'] = generate_owners_data

# # Write back to the file
# File.write('spec/fixtures/vcr_cassettes/v3/owners.yml', file.to_yaml)
