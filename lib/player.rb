# frozen_string_literal = false

class Player
  attr_accessor :name, :guess

  def initialize(name = "Player")
    self.name = name
    self.guess = ''
  end
end
