require 'restaurant'

describe Restaurant do

  let(:test_file) { 'spec/fixtures/restaurant_text.txt'}
  let(:crescent) { Restaurant.new(name: 'Crescent', cuisine: 'paleo', price: '321')}

  describe 'attributes' do
    it 'allows reading and writing for :name' do
      subject.name = 'Kebabs'
      expect(subject.name).to eq('Kebabs')
    end

    it 'allows reading and writing for :cuisine' do
      subject.cuisine = 'Turkish'
      expect(subject.cuisine).to eq('Turkish')
    end

    it 'allows reading and writing for :price' do
      subject.price = '123'
      expect(subject.price).to eq('123')
    end
  end

end 