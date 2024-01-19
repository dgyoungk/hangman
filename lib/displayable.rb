# frozen_string_literal = false

module Displayable
  # methods needed: welcome_msg, rules_msg, turn_msg, guess_msg, show_progress, farewell_msg, game_over_msg
  def welcome_msg()
    puts 'Hangman Initialized!'
    puts %(Let's play!)

  end

  # turns will be 9, the turns it takes to draw the gallow and the person
  # if the game gets too easy I can change this into 6
  def rules_msg
    puts %(You will have 9 turns to guess the answer word chosen at random)
    puts %(Once you guess 3 more letters, you can choose to try and guess the word)
    puts %(There will be no hangman actually being drawn, but you will see a turn counter)
    puts %(Good luck!)
  end

  # method to get the player name and initialize a new Player object
  def new_player_msg
    print %(What is your name? )
  end

  # called from Playable method
  def turn_msg(turn)
    puts %(Turn #{turn}:)
  end

  # something like player name's guess: (guess input value)
  # called from Playable method
  def guess_letter_msg
    print %(Enter a letter: )
  end

  # called from Playable method
  def show_progress

  end

  # called from Playable method
  def guess_incorrect_msg
    puts %(That letter is not part of the answer)
  end

  # called from Playable method
  def guess_correct_msg
    puts %(Correct!)
  end

  # show each turn only if the player guessed more than 3 letters correctly
  # called from Playable method
  def guess_answer_msg

  end

  # called from Playable method
  def game_over_msg

  end

  # end of game msg
  def farewell_msg

  end
end
