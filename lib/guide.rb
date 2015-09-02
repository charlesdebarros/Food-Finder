require 'restaurant'

class Guide

  def initialize(path=nil)
    # locate the restaurant text file at path
    Restaurant.filepath = path
    if Restaurant.file_usable?
      puts "Found restaurant file."
    elsif Restaurant.create_file
      puts "Created restaurant file."
    else
      puts "Exiting.\n\n"
      exit!
    end

      
    # or create a new file
    # exit if create fails
  end

  def launch!
    introduction

    # action loop
    #   what would you like to do? (list, find, add, quit)
    #   do that action
    # repeat until user chooses to quit
    conclusion
  end

  def introduction
    puts "\n\n<<< Welcome to Food Finder >>>\n\n"
    puts "This is an interactive guide to help you find the food you crave.\n\n"
  end

  def conclusion
    puts "\n<<< Goodbye and enjoy your meal! >>>\n\n\n"
  end

end