class Word
  @word

  def initialize(_word)
    @word = _word.strip.upcase
  end

  def letters
    return @word.split("")
  end

  def matches(_word)
    _count = 0
    my_letters = letters
    matching = _word.strip.upcase.split("")

    matching.each_with_index do |l,i|
      if l == my_letters[i]
        _count += 1
      end
    end
    return _count
  end

  def to_s
    return @word
  end
end
