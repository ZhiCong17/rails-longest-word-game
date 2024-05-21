class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    user_input = params[:input].upcase
    @letters = params[:letters].gsub(" ", ", ")
    @output = ""
    @valid_word = JSON.parse(RestClient.get "https://dictionary.lewagon.com/#{user_input}")["found"]

    if user_input.upcase.chars.all? { |char| user_input.count(char) <= @letters.count(char) }
      if @valid_word
        @output = "Congratulations! #{user_input} is a valid English word!"
      else
        @output = "Sorry but #{user_input} does not seem to be a valid English word..."
      end
    else
      @output = "Sorry but #{user_input} can't be built out of #{@letters}"
    end
  end
end
