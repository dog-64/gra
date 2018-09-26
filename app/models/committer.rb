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

    committers_2table(committers, url)
  end

  # создание pdf для коммиттера
  # @params id Integer код комитера
  # @result File
  def self.pdf(id)
    return unless (cmtr = Committer.find_by(id: id.to_i))
    Prawn::Document.generate(r = "tmp/award_#{cmtr.stock}_#{cmtr.author}_#{cmtr.place}.pdf") do
      move_down(200)
      text "PDF ##{cmtr.place}", align: :center, size: 48

      move_down(40)
      text "The awards goes to", align: :center, size: 32

      move_down(40)
      text cmtr.author, align: :center, size: 24
    end
    r
  end

  private

  def self.committers_2table(committers, url)
    Committer.where(repo: url).delete_all
    ids = committers_create(committers, url)
    Committer.where(stock: ids[0])
  end

  def self.committers_create(committers, url)
    ids = []
    Committer.transaction do
      committers.each do |cmt|
        c = cmt + { repo: url, stock: 0 }
        rc = Committer.create(c)
        ids << rc.id
      end
      Committer.where(id: ids).update_all(stock: ids[0])
    end
    ids
  end

end
