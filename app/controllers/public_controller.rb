require 'text_index'

class PublicController < ApplicationController
  def index
  end

  def new
    text = params['text']['post']

    @fre = TextIndex.calculate(text)[:fre]
  end
end
