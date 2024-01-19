# frozen_string_literal = false

module Playable
  # methods needed so far: check_guess, update_progress

  def start_game(match)
    until match.progress.join('').eql?(match.answer) || match.turns > 8
      # if there's more than 5 letters correctly guessed, allow the player to try and guess the answer word
      if get_letter_counts(match.progress) >= 5
        if guess_answer_msg == 'y'
          display_progress(match)
          player_guess_answer(match)
        else
          play_game(match)
        end
      else
        play_game(match)
      end
    end
  end

  def play_game(match)
    match.turns += 1
    match.turn_msg(match.turns)
    display_progress(match)
    match.guess_letter_msg
    get_guess(match)
    update_game(match)
  end

  def player_guess_answer(match)
    match.turns += 1
    match.player.word_guess = answer_choice_msg
    # if the player gets the answer
    if check_answer(match)
      match.progress = match.player.word_guess
      game_over_msg
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
    print %(Letters used: )
    puts match.used_letters.join(' ')
    print %(Current progress: )
    puts match.progress.join(' ')
  end

  def get_guess(match)
    letter = gets.chomp.downcase
      until letter.length < 2
        puts %(You can only guess one letter at a time)
        match.guess_letter_msg
        letter = gets.chomp.downcase
      end
    match.player.letter_guess = letter
    end

  def update_game(match)
    if match.answer.include?(match.player.letter_guess)
      update_progress(match)
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
