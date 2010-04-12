require 'rss/2.0'
require 'open-uri'

class NewsController < ApplicationController
  
  LINUX_SOURCE='http://lxer.com/module/newswire/headlines.rdf'
  GENERAL_SOURCE='http://www.pagina12.com.ar/diario/rss/ultimas_noticias.xml'
  
  def index
    
    feed_url=''
    if params[:source] == 'linux'
      feed_url = LINUX_SOURCE
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
