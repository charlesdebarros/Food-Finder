require 'restaurant'
require 'config'

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
    result = nil
    until result == :quit
      action = get_action
      result = do_action(action)
    end
    conclusion
  end

  def get_action
    action = nil
    until Config.actions.include?(action)
      puts "The options available are: " + Config.actions.join(", ") + "." if action
      print "> "
      user_response = gets.chomp
      action = user_response.downcase.strip
    end
    return action
  end

  def do_action(action)
    case action
    when 'list'
      list
    when 'find'
      puts 'Finding...'
    when 'add'
      add
    when 'quit'
      return :quit
    else 
      puts "\nThe action requested has not been recognised! Please try again.\n"
    end
  end

  def list
    puts "\nListing restaurants.\n\n"
    restaurants = Restaurant.saved_restaurants
    restaurants.each do |rest|
      puts rest.name + " | " + rest.cuisine + " | " + rest.formatted_price
    end
  end

  def add
    puts "\nAdd a restaurant\n\n".upcase
    
    restaurant = Restaurant.profile_builder

    if restaurant.save
      puts "\nNew restaurant added.\n\n"
    else
      puts "\nAn error has occurred. Restaurant not added.\n\n"
    end
  end

  def introduction
    puts "\n\n<<< Welcome to Food Finder >>>\n\n"
    puts "This is an interactive guide to help you find the food you crave.\n\n"
  end

  def conclusion
    puts "\n<<< Goodbye and enjoy your meal! >>>\n\n\n"
  end

end