# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
describe Hubspot::V3::Owner do
  before do
    Hubspot.configure(access_token: 'demo')
  end
  let(:owner_params) do
    {
      id: '277857',
      email: 'ailene@cummings-will.example',
      type: 'PERSON',
      firstName: 'Ken',
      lastName: 'Harber'
    }
  end

  let(:owner) do
    build(:v3_owner, owner_params)
  end

  describe 'listing owners' do
    cassette 'v3/owners/all'

    it 'should find all owners' do
      owners = Hubspot::V3::Owner.all
      expect(owners.blank?).to be false
      expect(owners.length).to eq(25)
      expect(owners.map(&:email)).to include(owner.email)
    end

    it 'should respect pagination parameters' do
      owners = Hubspot::V3::Owner.all(limit: 5)
      expect(owners.length).to be <= 5
    end

    it 'should include inactive owners when requested' do
      owners = Hubspot::V3::Owner.all(include_inactive: true)
      expect(owners.any? { |owner| !owner['active'] }).to be true
    end
  end

  describe 'finding owners' do
    let(:sample) { example_owners['results'].first }

    describe '.find' do
      cassette 'v3/owners/find'

      let(:owner_id) { '277857' }

      it 'should find a user by their ID' do
        owner = Hubspot::V3::Owner.find(owner_id)
        expect(owner.owner_id).to eq(owner_id)
        expect(owner.email).to eq(owner_params[:email])
      end
    end

    describe '.find_by_email' do
      cassette 'v3/owners/find_by_email'

      let(:email) { 'ailene@cummings-will.example' }

      it 'should find a user via their email address' do
        owner = Hubspot::V3::Owner.find_by_email(email)
        expect(owner.owner_id).to eq(owner_params[:id])
        expect(owner.email).to eq(owner_params[:email])
      end

      it 'should return nil for non-existent email' do
        owner = Hubspot::V3::Owner.find_by_email('nonexistent@example.com')
        expect(owner).to be_nil
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
def compare_owners(owners, examples)
  owners.each do |owner|
    example = examples.detect { |o| o['email'] == owner.email }
    expect(example.blank?).to be false
    example.each do |key, val|
      expect(owner[key]).to eq(val)
    end
  end
end
