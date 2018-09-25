# получение данных о репозитории GitHub
class Repo
  require 'net/http'
  require 'json'

  # взяти данных о комиттерах репозитория
  # @param url String
  # @result Hash
  def self.get(url)
    return if url.blank?
    return unless url =~ %r{(https|http)://github.com/(\w+)/(\w+)}
    uri = URI("https://api.github.com/repos/#{$2}/#{$3}/stats/contributors")

    begin
      json = Net::HTTP.get(uri)
      @result = JSON(json)
    rescue StandardError => e
      Rails.logger.error "#{__FILE__}, #{__LINE__} | Exception=#{e.inspect}"
      return
    end
    # контрибуторы уже упорядочены в json, от меньших к большим
    @result.map {|rs| {total: rs['total'], author: rs['author']['login']}}
        .last(3)
        .reverse
        .map.with_index {|rs, j| rs.merge(place: j + 1)}
  end

end