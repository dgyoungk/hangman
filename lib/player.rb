# frozen_string_literal = false

require_relative 'basic_serializable.rb'

class Player
  include BasicSerializable
  attr_accessor :name, :guess, :word_guess, :letter_guess

  def initialize(name = "Player")
    self.name = name
    self.letter_guess = ''
    self.word_guess = ''

  end
end
