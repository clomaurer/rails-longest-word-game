require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    if word_valid_grid?(params[:word], params[:grid].downcase) && word_valid_english?(params[:word])
      @result = "Congratulations! #{params[:word]} is a valid English word!"
    elsif word_valid_grid?(params[:word], params[:grid].downcase)
      @result = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    else
      @result = "Sorry but #{params[:word]} can't be built out of the grid"
    end
  end

  def word_valid_grid?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def word_valid_english?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
