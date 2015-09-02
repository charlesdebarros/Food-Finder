require 'restaurant'
require 'config'
require 'support/string_extend'

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
    output_action_header("listing restaurants")
    restaurants = Restaurant.saved_restaurants
    output_restaurant_table(restaurants)
  end

  def add
    output_action_header("add a restaurant")
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

  private

  def output_action_header(text)
    puts "\n#{text.upcase.center(60)}\n\n"
  end

  def output_restaurant_table(restaurants=[])
    print " " + "Name".ljust(30)
    print " " + "Cuisine".ljust(20)
    print " " + "Price".rjust(6) + "\n"
    puts "-" * 60
    restaurants.each do |rest|
      line = " " << rest.name.titleize.ljust(30)
      line << " " + rest.cuisine.titleize.ljust(20)
      line << " " + rest.formatted_price.rjust(6)
      puts line
    end
    puts "No listings found." if restaurants.empty?
    puts "-" * 60
  end

end