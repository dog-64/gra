# комиттеры в репозитории
class Committer < ApplicationRecord

  validates :repo, presence: true
  validates :author, presence: true
  validates :total, presence: true
  validates :place, presence: true
  validates :stock, presence: true

  # запись в БД топа комиттеров
  # @params url String адрес репозитория
  # @params ActiveRecord::Relation список записей
  def self.create_by_url(url)
    return unless (committers = Repo.get(url))

    Committer.where(repo: url).delete_all
    Committer.transaction do
      ids = committers.map do |cmt|
        c = cmt + { repo: url, stock: 0 }
        rc = Committer.create(c)
        rc.id
      end
      Committer.where(id: ids).update_all(stock: ids[0])
    end
    Committer.where(id: ids)
  end
end
