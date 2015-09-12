# encoding: UTF-8

require 'support/string_extend'

describe 'String' do

  describe "#titleize" do

    it "capitalizes each word in a string" do
      expect("the quick brown fox".titleize).to eq("The Quick Brown Fox")
    end
    
    it "works with single-word strings" do
      expect("pineapple".titleize).to eq("Pineapple")
    end
    
    it "capitalizes all uppercase strings" do 
      expect("ALL CAPITALS".titleize).to eq("All Capitals")
    end
    
    it "capitalizes mixed-case strings" do
      expect("sOmE CRazY StRINg".titleize).to eq("Some Crazy String")
    end
    
  end
  
  describe '#blank?' do

    it "returns true if string is empty" do
      expect(''.blank?).to be true
    end

    it "returns true if string contains only spaces" do
      expect('   '.blank?).to be true
    end

    it "returns true if string contains only tabs" do
    # Get a tab using a double-quoted string with \t
    # example: "\t\t\t"
      expect("\t\t\t".blank?).to be true
    end

    it "returns true if string contains only spaces and tabs" do
      expect(" \t  \t".blank?).to be true
    end
    
    it "returns false if string contains a letter" do
      expect("c".blank?).to be false
    end

    it "returns false if string contains a number" do
      expect("8".blank?).to be false
    end
    
  end
  
end
