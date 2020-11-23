require 'rails_helper'

RSpec.describe Coordinate, type: :model do
  subject { described_class.new(latitude: 39.6, longitude: -94.5,)}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a latitude" do
    subject.latitude = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with latitude being a string of letters" do
    subject.latitude = "test"
    expect(subject.save).to be_falsy
  end

  it "is not valid without a longitude" do
    subject.longitude = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with longitude being a string of letters" do
    subject.longitude = "test"
    expect(subject.save).to be_falsy
  end

  describe '#get_closest_pharma' do
    let(:lat) { 34.6 }
    let(:lon) { -94.7 }
    let(:pharmacy) { Coordinate.new(latitude: lat, longitude: lon)}
    let(:result) { pharmacy.get_closest_pharma }

    context 'when get_closest_pharma gets called' do
      it 'will always return the closest pharmacy no matter the coordinates' do
        expect(result).to include(:name,:address,:miles)
      end
    end
  end
end
