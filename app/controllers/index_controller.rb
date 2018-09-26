# главная страница, запрос url и показ результата запроса к api github
class IndexController < ApplicationController
  def index; end

  def show
    @committers = Committer.create_by_url(params[:url])
    pp "#{__FILE__}, #{__LINE__} | @committers=#{@committers.inspect}"
  end
end
