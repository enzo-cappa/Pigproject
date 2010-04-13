require 'rss/2.0'
require 'open-uri'

class NewsController < ApplicationController
  
  LINUX_SOURCE='http://lxer.com/module/newswire/headlines.rdf'
  GENERAL_SOURCE='http://www.pagina12.com.ar/diario/rss/principal.xml'
  SPORTS_SOURCE='http://espndeportes-assets.espn.go.com/rss/news?cc=7586'
  ECONOMY_SOURCE='http://www.pagina12.com.ar/diario/rss/cash.xml'
  MUSIC_SOURCE='http://www.pagina12.com.ar/diario/rss/no.xml'
  
  def index
    
    feed_url=''
    if params[:source] == 'linux'
      feed_url = LINUX_SOURCE
    elsif params[:source] == 'sports'
      feed_url = SPORTS_SOURCE
    elsif params[:source] == 'economy'
      feed_url = ECONOMY_SOURCE
    elsif params[:source] == 'music'
      feed_url = MUSIC_SOURCE
    else      
      feed_url = GENERAL_SOURCE
    end
    
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
