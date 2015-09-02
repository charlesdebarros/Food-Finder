# Opening core Ruby String class
# in order to add a new method to all strings

class String

  # Creating a method to 'capitalise' the first letter of EVERY word in a sentence/title

  def titleize
    self.split(' ').collect {|word| word.capitalize}.join(" ")
  end

end