# -*- coding: UTF-8 -*-

class TextIndex

  def self.calculate text
    while text.scan(/\ \ /).count > 0
      text.gsub!('  ', ' ')
    end

    sentenses  = text.scan(/\./).count
    words      = text.scan(/\ /).count+1
    syllables  = text.scan(/[уеыаоэёяию]/).count

    asl        = words.to_f / sentenses
    asw        = syllables.to_f  / words

    fre        = 206.835 - (1.3 * asl) - (60.1 * asw)

    {:fre => fre, :sentenses => sentenses, :words => words, :syllables => syllables}
  end

end
