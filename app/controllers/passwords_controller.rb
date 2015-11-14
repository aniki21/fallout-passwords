class PasswordsController < ApplicationController

  # GET /passwords
  # Input the list of words
  def start
    # nothing required
  end

  # POST /passwords
  # Form with list of words
  def start_matches
    @words = []
    entries = params[:words].split("\n").map{|w| w.strip }
    entries.each do |entry|
      @words.push(Word.new(entry))
    end
  end

  # POST  /passwords/match
  def try_matches
    @words = []
    @word_to_match = params[:matches].select{|w,m| !m.blank? }.first

    entries = params[:words].split(",")
    entries.each do |entry|
      w = Word.new(entry)
      matches = w.matches(@word_to_match[0])
      if matches == @word_to_match[1].to_i
        @words.push(w)
      end
    end
    render action: :start_matches and return
  end

end
