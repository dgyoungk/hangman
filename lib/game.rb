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
    game_setup
  end

  # def reset
  #   # self.turns = 0
  #   # self.used_letters = []
  #   # self.answer = get_answer()
  #   # self.progress = get_progress(answer)
  #   replay = Game.new
  # end

  def prompt_load_save
    game_load_msg
    case check_choice()
    when 'y'
      puts %(Loading saved game... )
      save_file = load_saved_file(@@save_path)
      loaded_info = deserialize(save_file).values
      loaded_game = Game.new(loaded_info[0], loaded_info[1], loaded_info[2], loaded_info[3], loaded_info[4])
    when 'n'
      new_game
    end
  end

  def prompt_game_save
    game_save_msg
    if check_choice == 'y'
      save_to_file(@@save_path, self.serialize)
      true
    else
      play_game(self)
      false
    end
  end

  private

  def game_setup()
    welcome_msg()
    # checks if a save file exists before prompting to load
    if File.exist?(@@save_path)
      prompt_load_save
    end
  end

  def new_game
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
