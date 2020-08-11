require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @word = params[:word]
    @alphabet = ('A'..'Z').to_a
    @letters = []
    10.times { @letters << @alphabet.sample }
  end

  def score
    @letters = params[:letters].split
    @word = params[:word]
    @guess_desc = {
      included: included?(@word, @letters),
      english: english_word?(@word)
    }
    raise
  end

  private

  def included?(guess, grid)
    guess.upcase.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

end
