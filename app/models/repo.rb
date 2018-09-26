# получение данных о репозитории GitHub
class Repo
  require 'net/http'
  require 'json'

  # взятие данных о комиттерах репозитория
  # @param url String
  # @result Hash
  def self.get(url)
    return if url.blank?
    return unless url =~ %r{(https|http)://github.com/([^/]+)/([^/]+)}

    uri = URI("https://api.github.com/repos/#{$2}/#{$3}/stats/contributors")

    begin
      Rails.cache.fetch("#{url}/repo", expires_in: 1.hours) do
        pp "#{__FILE__}, #{__LINE__} | API"
        json = Net::HTTP.get(uri)
        @result = JSON(json)
      end
    rescue StandardError => e
      Rails.logger.error "#{__FILE__}, #{__LINE__} | Exception=#{e.inspect}"
      return
    end
    return unless @result.class == Array # лимит обращений

    # контрибуторы уже упорядочены в json, от меньших к большим
    @result.map { |rs| { total: rs['total'], author: rs['author']['login'] } }
        .last(3)
        .reverse
        .map.with_index { |rs, j| rs.merge(place: j + 1) }
  end

end