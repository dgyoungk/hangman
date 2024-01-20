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

  attr_accessor :turns, :player, :used_letters, :progress, :answer

  def initialize(turns = 0, used_letters = [], answer = get_answer(@@answer_path), progress = get_progress(answer), player = Player.new)
    self.turns = turns
    self.used_letters = used_letters
    # progress and answer init should be handled by a method that reads from the txt file and gets the value first
    # from the BasicSerializable module
    self.answer = answer
    self.progress = progress
    self.player = player
  end

  def save_game(match)
    # self.player = self.player.serialize
    save_to_file(@@save_path, match.serialize)
  end

  def game_setup()
    welcome_msg()
    if File.exist?(@@save_path)
      game_load_msg
      if check_choice == 'y'
        open_saved_game
      else
        new_game
      end
    else
      new_game
    end
  end

  private

  def open_saved_game
    puts %(Loading saved game... )
    loaded_info = deserialize(load_saved_file(@@save_path)).values
    saved_game = Game.new(loaded_info[0].to_i, loaded_info[1], loaded_info[2], loaded_info[3], Player.new(loaded_info[4]))
    start_game(saved_game)
  end

  def new_game
    new_player_msg
    self.player = Player.new(gets.chomp)
    rules_msg()
    File.delete(@@save_path) if File.exist?(@@save_path)
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
