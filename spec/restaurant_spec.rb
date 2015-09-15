require 'restaurant'
require 'restaurant_file'

describe Restaurant do

  let(:test_file) { 'spec/fixtures/restaurants_test.txt' }
  let(:chiquitos) { Restaurant.new(:name => 'Chiquitos', :cuisine => 'spanish', :price => '150') }
  
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
  
  describe '.load_file' do

    it 'does not set @@file if filepath is nil' do
      no_output { Restaurant.load_file(nil) }
      expect(Restaurant.file).to be_nil
    end
    
    it 'sets @@file if filepath is usable' do
      no_output { Restaurant.load_file(test_file) }
      expect(Restaurant.file).not_to be_nil
      expect(Restaurant.file.class).to be(RestaurantFile)
      expect(Restaurant.file).to be_usable
    end

    it 'outputs a message if filepath is not usable' do
      expect do
        Restaurant.load_file(nil)
      end.to output(/not usable/).to_stdout
    end
    
    it 'does not output a message if filepath is usable' do
      expect do
        Restaurant.load_file(test_file)
      end.not_to output.to_stdout
    end
    
  end
  
  describe '.all' do
    
    it 'returns array of restaurant objects from @@file' do
      Restaurant.load_file(test_file)
      restaurants = Restaurant.all
      expect(restaurants.class).to eq(Array)
      expect(restaurants.length).to eq(6)
      expect(restaurants.first.class).to eq(Restaurant)
    end

    it 'returns an empty array when @@file is nil' do
      no_output { Restaurant.load_file(nil) }
      restaurants = Restaurant.all
      expect(restaurants).to eq([])
    end
    
  end

  describe '#initialize' do

    context 'with no options' do
      # subject would return the same thing
      let(:no_options) { Restaurant.new }

      # subject already calls #new using default options

      it 'sets a default of "" for :name' do
        expect(subject.name).to eq("")
      end

      it 'sets a default of "unknown" for :cuisine' do
        expect(subject.cuisine).to eq("unknown")
      end

      it 'does not set a default for :price' do
        expect(subject.price).to be_nil
      end

    end
    
    context 'with custom options' do

      # chiquitos already calls #new using custom options
      
      it 'allows setting the :name' do
        expect(chiquitos.name).to eq('Chiquitos')
      end

      it 'allows setting the :cuisine' do
        expect(chiquitos.cuisine).to eq('spanish')
      end

      it 'allows setting the :price' do
        expect(chiquitos.price).to eq('150')
      end

    end

  end

  describe '#save' do
    
    it 'returns false if @@file is nil' do
      expect(Restaurant.file).to be_nil
      expect(chiquitos.save).to be false
    end
    
    it 'returns false if not valid' do
      Restaurant.load_file(test_file)
      expect(Restaurant.file).not_to be_nil

      # subject will be invalid by default
      expect(subject.save).to be false
    end
    
    it 'calls append on @@file if valid' do
      Restaurant.load_file(test_file)
      expect(Restaurant.file).not_to be_nil

      # Message expectation on partial test double
      expect(Restaurant.file).to receive(:append).with(chiquitos)
      chiquitos.save
    end
    
  end

  describe '#valid?' do
    
    it 'returns false if name is nil' do
      chiquitos.name = nil
      expect(chiquitos.valid?).to be false
    end

    it 'returns false if name is blank' do
      chiquitos.name = "   "
      expect(chiquitos.valid?).to be false
    end

    it 'returns false if cuisine is nil' do
      chiquitos.name = nil
      expect(chiquitos.valid?).to be false
    end

    it 'returns false if cuisine is blank' do
      chiquitos.cuisine = "   "
      expect(chiquitos.valid?).to be false
    end
    
    it 'returns false if price is nil' do
      chiquitos.price = nil
      expect(chiquitos.valid?).to be false
    end

    it 'returns false if price is 0' do
      chiquitos.price = 0
      expect(chiquitos.valid?).to be false
    end
    
    it 'returns false if price is negative' do
      chiquitos.price = -20
      expect(chiquitos.valid?).to be false
    end

    it 'returns true if name, cuisine, price are present' do
      expect(chiquitos.valid?).to be true
    end
    
  end

  
end
