# frozen_string_literal = false

require_relative 'displayable.rb'

module Playable
  include Displayable
  # methods needed so far: check_guess, update_progress

  def start_game(match)
    saved = false
    until game_won?(match) || match.turns > 8
      # if there's more than 3 letters correctly guessed, allow the player to try and guess the answer word
      play_game(match)
      if get_letter_counts(match.progress) >= 3 && match.turns < 9
        display_progress(match)
        guess_answer_msg
        if check_choice == 'y'
          player_guess_answer(match)
        end
      end
      game_save_msg
      if check_choice == 'y'
        save_game(match)
        saved = true
        break
      end
    end
    end_of_game(match, saved)
  end

  def end_of_game(match, saved)
    if saved
      farewell_msg
    elsif game_won?(match)
      game_won_msg
    else
      game_lost_msg
      display_answer(match)
    end
  end

  def check_choice
    choice = gets.chomp.downcase
    until choice == 'y' || choice == 'n'
      print %(That's not a valid choice, try again: )
      choice = gets.chomp.downcase
    end
    choice
  end

  def game_won?(match)
    match.progress.join('').eql?(match.answer)
  end

  def display_answer(match)
    puts %(The answer was #{match.answer})
  end

  def play_game(match)
    match.turns += 1
    turn_msg(match.turns)
    # puts match.answer
    display_progress(match)
    guess_letter_msg
    letter = get_guess(match)
    update_game(match, letter)
  end

  def player_guess_answer(match)
    match.turns += 1
    turn_msg(match.turns)
    # display_progress(match)
    answer_choice_msg
    match.player.word_guess = gets.chomp.downcase
    # if the player gets the answer
    if check_answer(match)
      match.progress = match.player.word_guess.split('')
    else
      guess_wrong_msg
    end
  end

  def check_answer(match)
    match.answer.eql?(match.player.word_guess)
  end

  def get_letter_counts(progress)
    alphabet_only = /^[A-Za-z]+$/
    counts = progress.each.with_object([]) do |item, arr|
      if item.match?(alphabet_only)
        arr.push(item)
      end
    end
    counts.size
  end

  def display_progress(match)
    print %(\nLetters used: )
    puts match.used_letters.join(' ')
    print %(Current progress: )
    puts match.progress.join(' ')
  end

  def get_guess(match)
    alphabet_only = /^[A-Za-z]+$/
    letter = gets.chomp.downcase
    while letter.length > 1 || match.used_letters.include?(letter) || !letter.match?(alphabet_only)
      invalid_input_msg
      guess_letter_msg
      letter = gets.chomp.downcase
    end
    letter
  end

  def update_game(match, letter)
    match.player.letter_guess = letter
    if match.answer.include?(match.player.letter_guess)
      letter_correct_msg
      update_progress(match)
      used_letters.push(match.player.letter_guess)
      # debugging
      # p match.answer
      # p match.progress.join(' ')
    else
      letter_incorrect_msg
      match.used_letters.push(match.player.letter_guess)
      # p match.answer
    end

  end

  def update_progress(match)
    match.progress.each_with_index do |space, idx|
      if match.answer[idx] == match.player.letter_guess
        match.progress[idx] = match.player.letter_guess
      end
    end
  end
end
