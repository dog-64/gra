class IndexController < ApplicationController

  def index
  end

  def show
    @committers = Committer.create_by_url(params[:url])
  end


end
