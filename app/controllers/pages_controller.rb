class PagesController < ApplicationController
	require 'mini_magick'

  def home
  	@masks = Mask.all



  end
end