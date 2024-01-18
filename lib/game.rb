# frozen_string_literal = false

require_relative 'playable.rb'
require_relative 'displayable.rb'
require_relative 'player.rb'
require_relative 'fileable.rb'

class Game
  include Playable
  include Fileable
  include Player
  attr_accessor :turn, :player, :incorrect_used, :correct, :progress, :answer

  def initialize()
    self.turns = 0
    # self.player = Player.new sort this out after Player class has been created
    self.incorrect_used = []
    self.correct = []
    # progress and answer init should be handled by a method that reads from the txt file and gets the value first
    # from the Fileable module
  end


end
