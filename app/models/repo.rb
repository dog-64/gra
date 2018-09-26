# получение данных о репозитории GitHub
class Repo
  require 'net/http'
  require 'json'

  # взятие данных о комиттерах репозитория
  # @param url String адрес репо
  # @result Hash
  def self.get(url)
    return unless (uri = url_4api(url))
    return unless (committers = api_call(uri))

    committers_format(committers)
  end

  # приведение url репозитория к url запроса к api github
  # @param url String адрес репо
  # @result String
  def self.url_4api(url)
    return if url.blank?
    return unless url =~ %r{(https|http)://github.com/([^/]+)/([^/]+)}

    URI("https://api.github.com/repos/#{$2}/#{$3}/stats/contributors")
  end

  # приведение url репозитория к url запроса к api github
  # @param uri String адрес запроса к api github
  # @result String
  private_class_method def self.api_call(uri)
    result = nil
    begin
      json = Net::HTTP.get(uri)
      result = JSON(json)
    rescue StandardError => e
      return
    end
    return unless result.class == Array # лимит обращений

    result
  end

  # форматирование данных о комитерах
  # @params committers Hash комитеры
  # @result Hash
  private_class_method def self.committers_format(committers)
    # контрибуторы уже упорядочены в json, от меньших к большим
    committers.map { |rs| { total: rs['total'], author: rs['author']['login'] } }
        .last(3)
        .reverse
        .map.with_index { |rs, j| rs.merge(place: j + 1) }
  end
end