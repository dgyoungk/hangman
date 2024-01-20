# frozen_string_literal = false

# TODO: DEBUG THE GAME-SAVING AND GAME-LOADING FUNCTIONALITY

module Playable
  # methods needed so far: check_guess, update_progress

  def start_game(match)
    until game_won?(match) || match.turns > 8
      # if there's more than 5 letters correctly guessed, allow the player to try and guess the answer word
      if match.prompt_game_save
        break
      end
      if get_letter_counts(match.progress) >= 3 && match.turns < 9
        display_progress(match)
        if guess_answer_msg == 'y'
          player_guess_answer(match)
        end
      end
    end
    end_of_game(match)
  end

  def end_of_game(match)
    if match.prompt_game_save
      match.farewell_msg
    elsif game_won?(match)
      match.game_won_msg
    else
      match.game_lost_msg
      display_answer(match)
    end
  end

  def check_choice()
    save_choice = gets.chomp.downcase
    until save_choice == 'y' || save_choice == 'n'
      puts %(That's not a valid choice, try again)
      match.game_save_msg
      save_choice = gets.chomp.downcase
    end
    save_choice
  end

  def game_won?(match)
    match.progress.join('').eql?(match.answer)
  end

  def display_answer(match)
    puts %(The answer was #{match.answer})
  end

  def play_game(match)
    match.turns += 1
    match.turn_msg(match.turns)
    # puts match.answer
    display_progress(match)
    match.guess_letter_msg
    letter = get_guess(match)
    update_game(match, letter)
  end

  def player_guess_answer(match)
    match.turns += 1
    match.turn_msg(match.turns)
    # display_progress(match)
    match.player.word_guess = answer_choice_msg
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
      match.invalid_input_msg
      match.guess_letter_msg
      letter = gets.chomp.downcase
    end
    letter
  end

  def update_game(match, letter)
    match.player.letter_guess = letter
    if match.answer.include?(match.player.letter_guess)
      match.letter_correct_msg
      update_progress(match)
      match.used_letters.push(match.player.letter_guess)
      # debugging
      # p match.answer
      # p match.progress.join(' ')
    else
      match.letter_incorrect_msg
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
