require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      letter = ('a'..'z').to_a.sample
      @letters.push(letter)
    end
    @letters
    # @letters = ('a'..'z').to_a.sample(10)
  end

  def parsing
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    url_read = URI.open(url).read
    JSON.parse(url_read)
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split
    if (@word.split(//) - @letters).empty?
      if parsing['found'] == true
        @answer = "Congratulations! #{@word} is a valid English word!"
      else
        @answer = "Sorry but #{@word} does not seem to be a valid English word..."
      end
    else
      @answer = "Sorry but #{@word} can not be built out of #{@letters}"
    end
  end
end
