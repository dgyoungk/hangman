# frozen_string_literal = false

require_relative 'playable.rb'
require_relative 'displayable.rb'
require_relative 'player.rb'
require_relative 'basic_serializable.rb'

class Game
  include Playable
  include BasicSerializable
  include Displayable

  @@answer_path = './google-10000-english-no-swears.txt'
  @@save_path  ='./saves/sv_file.txt'

  attr_accessor :turns, :player, :incorrect_used, :correct, :progress, :answer

  def initialize()
    self.turns = 0
    self.incorrect_used = []
    self.correct = []
    # progress and answer init should be handled by a method that reads from the txt file and gets the value first
    # from the BasicSerializable module
    self.answer = get_answer(@@answer_path)
    self.progress = get_progress(answer)
    game_setup
  end


  private

  def game_setup()
    welcome_msg()
    new_player_msg
    self.player = Player.new(gets.chomp)
    rules_msg()
    start_game(self)
  end

  # returns the guessing area i.e. _ _ _ _ _
  def get_progress(answer_word)
    # it should be an array so that the blank spot can be replaced by the correct guess
    area = answer_word.length.times.with_object([]) do |n, arr|
      arr.push('_')
    end
    # when displaying the guessing area, use #join with space as the delimiter
  end

end
