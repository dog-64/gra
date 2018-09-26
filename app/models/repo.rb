# получение данных о репозитории GitHub
class Repo
  require 'net/http'
  require 'json'

  # взятие данных о комиттерах репозитория
  # @param url String адрес репо
  # @result Hash
  def self.get(url)
    return 'пустой url' if url.blank?
    return 'ошибка формата url' unless (uri = url_4api(url))

    cmtrs = api_call(uri)
    return cmtrs if cmtrs.class == String
    return 'несуществующий репозиторий' if cmtrs.class == Hash && cmtrs.dig('message') == 'Not Found'
    return 'исчерпаны лимиты обращения к api.github.com' unless cmtrs.class == Array

    committers_format(cmtrs)
  end

  # проверка - возвращенное значение ошибка?
  # @param url String адрес репо
  # @result Hash
  def self.err?(value)
    value.class == String
  end

  # приведение url репозитория к url запроса к api github
  # @param url String адрес репо
  # @result String
  def self.url_4api(url)
    return if url.blank?
    return unless url =~ %r{\s*(https|http)://github.com/([^/]+)/([^/\s]+)\s*}

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
      return e.message
    end
    pp "#{__FILE__}, #{__LINE__} | self.api_call(#{uri})=#{result.inspect}"
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