# комиттеры в репозитории
class Committer < ApplicationRecord

  validates :repo, presence: true
  validates :author, presence: true
  validates :total, presence: true
  validates :place, presence: true
  validates :stock, presence: true

  # запись в БД топа комиттеров в репо
  # @params url String адрес репозитория
  # @params ActiveRecord::Relation список записей
  def self.create_by_url(url)
    return unless (committers = Repo.get(url))

    Committer.where(repo: url).delete_all
    ids = []
    Committer.transaction do
      committers.each do |cmt|
        c = cmt + { repo: url, stock: 0 }
        rc = Committer.create(c)
        ids << rc.id
      end
      Committer.where(id: ids).update_all(stock: ids[0])
    end
    Committer.where(stock: ids[0])
  end
end
