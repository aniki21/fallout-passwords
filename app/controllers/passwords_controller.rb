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
    entries = params[:words].split(/\W+/)
    entries.each do |entry|
      @words.push(Word.new(entry))
    end
    
    unless @words.any?
      flash[:error] = "No words entered"
      redirect_to :back and return
    end

    @attempts = 0
    @remaining = 4

    @suggestion = suggest(@words)
  end

  # POST  /passwords/match
  def try_matches
    @words = []
    @word_to_match = params[:matches].select{|w,m| !m.blank? }.first

    @attempts = params[:attempts].to_i + 1
    @remaining = 4 - @attempts

    entries = params[:words].split(",")
    entries.each do |entry|
      w = Word.new(entry)
      matches = w.matches(@word_to_match[0])
      if matches == @word_to_match[1].to_i
        @words.push(w)
      end
    end

    unless @words.any?
      flash[:error] = "No words match"
      redirect_to passwords_path and return
    end

    @suggestion = suggest(@words)
    render action: :start_matches and return
  end

  private
  def suggest(words)
    matches = {}
    words.each do |word|
      matches[:"#{word}"] = 0
      words.each do |w|
        unless word == w
          if word.matches(w) > 0
            matches[:"#{word}"] += 1
          end
        end
      end
    end
    matches = matches.sort{|a,b| a[1] <=> b[1] }
    return matches.first[0].to_s
  end

end
