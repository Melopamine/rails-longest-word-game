require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = generate_random_letters(10)
  end

  def score
    @submitted_word = params[:word]
    @random_letters = params[:letters].split
    @score, @message = compute_score_and_message(@submitted_word, @random_letters)
  end

  private

  def english_word?(word)
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}").open.read
    json_response = JSON.parse(response)
    json_response['found'] == true
  end

  def generate_random_letters(count)
    Array.new(count) { ('A'..'Z').to_a.sample }
  end

  def compute_score_and_message(submitted_word, random_letters)
    return [0, "#{submitted_word.capitalize} is not an English word."] unless english_word?(submitted_word)

    score = 0
    submitted_word.chars.each do |char|
      if random_letters.include?(char.upcase)
        score += 15
        random_letters.delete_at(random_letters.index(char.upcase))
      else
        return [0, "#{submitted_word.capitalize} can't be built out of the original grid."]
      end
    end

    [score, 'Well done']
  end
end
