# frozen_string_literal = false

module Playable
  # methods needed so far: check_guess, update_progress

  def start_game(match)
    until match.progress.join('').eql?(match.answer) || match.turns > 9
      match.turns += 1
      match.turn_msg(match.turns)
      match.guess_letter_msg
      letter = gets.chomp.downcase
      until letter.length < 2
        puts %(You can only guess one letter at a time)
        match.guess_letter_msg
        letter = gets.chomp.downcase
      end
      match.player.guess = letter
      update_progress(match)
    end
  end

  def check_guess(answer, letter)
    answer.include?(letter)
  end

  def update_progress(match)
    if check_guess(match.answer, match.player.guess)
      match.guess_correct_msg
      match.progress.each_with_index do |space, idx|
        if match.answer[idx] == match.player.guess
          match.progress[idx] = match.player.guess
          match.correct.push(match.player.guess)
        end
      end
    else
      match.guess_incorrect_msg
      match.incorrect_used.push(match.player.guess)

    end
  end
end
