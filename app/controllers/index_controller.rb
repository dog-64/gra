class IndexController < ApplicationController

  def index
  end

  def show
    Rails.logger.error "#{__FILE__}, #{__LINE__} | params=#{params.inspect}"
    Rails.logger.error "#{__FILE__}, #{__LINE__} | url=#{params[:url]}"

    # byebug
    # @commiters = result.map {|rs| {total: rs['total'], author: rs['author']['login']}}.last(3).reverse.map.with_index {|rs, j| rs.merge({place: j + 1})}
    @commiters = [{total: 4220, author: 'tenderlove', place: 1},
                  {total: 3945, author: 'dhh', place: 2},
                  {total: 3282, author: 'jeremy', place: 3}]
  end


end
