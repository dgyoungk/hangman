# frozen_string_literal = false

require_relative 'game.rb'

match = Game.new


# upon start of a new game, select a word from the .txt file to use as the word to guess
# choosing how many turns should be allowed for each game... e.g. the turns it takes to draw just the person
# or the turns it takes to draw the person and the gallow
# each letter guess should be case insensitive, so #downcase should be applied to every input (maybe looks like getc.chomp.downcase?)
# classes and modules
# Player class, Game class, Gameinfo class(?), playable module, displayable module, a module for serializing/deserializing
# also, the option to save the current game state into a file for play in the future...
# serializing objects... an object of the Game class should be serialized
# into a text file?
# serializing is turning an associated array (hash) into a single string...

# Game class
# attributes: turns, player, answer, progress (the guessing area) to start
# I need to store the already-used, incorrect guesses so that the player doesn't guess them again
# incorrect_used: []
# I also need to store the correctly guessed chars and update progress
# correct: []
# the answer attribute will be randomly picked from the .txt file

# Player class
# attributes: name, guess to start
# I need a way to clear out the guess attribute after every turn
# should this method be in the Player class or the Playable module?


# Playable module
# methods: #check_guess, #update_progress to start
# check_guess will need the answer value, the guess value, final return: boolean value?
# update_progress will need the return value of check_guess, the incorrect array, correct array, and the guessing area


# Displayable module
# methods: #welcome_msg, #rules_msg, #turn_msg, #progress_msg, #game_over_msg, #farewell_msg to start
# when the game starts:
# welcome_msg, player init, rules_msg, turn_msg, display the current progress (incorrect_used array, guessing area)
# guess_msg, get the guess and store it into the player object

# Fileable module
# methods: one to read file (for answer), one to write to file, one to serialize, one to de-serialize (saving function)
# maybe use JSON as the format and save that json into a txt file?
# since the reading method will be reading from a txt file I can just reuse that method for opening the game-progress JSON
