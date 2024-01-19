# frozen_string_literal = false

class Player
  attr_accessor :name, :guess, :word_guess, :letter_guess

  def initialize(name = "Player")
    self.name = name
    self.letter_guess = ''
    self.word_guess = ''
  end
end
