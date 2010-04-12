require 'rss/2.0'
require 'open-uri'

class NewsController < ApplicationController
  def index
    feed_url = 'http://www.pagina12.com.ar/diario/rss/ultimas_noticias.xml'
    output = "<h1>Noticias</h1>" 
    open(feed_url, :proxy => 'http://172.16.102.1:3128') do |http|
      response = http.read
      @rss = RSS::Parser.parse(response, false)
    end
  end

  protected

  def authorize
  end

end
