# комиттеры в репозитории
class Committer < ApplicationRecord
  validates :repo, presence: true
  validates :author, presence: true
  validates :total, presence: true
  validates :place, presence: true
  validates :stock, presence: true

  # каталог для записи
  DIR = Rails.root.join('temp', 'awards').freeze

  # запись в БД топа комиттеров в репо
  # @params url String адрес репозитория
  # @params ActiveRecord::Relation список записей
  def self.create_by_url(url)
    cmtrs = Repo.get(url)
    return cmtrs if Repo.err?(cmtrs)

    committers_2table(cmtrs, url)
  end

  # создание pdf для коммиттера
  # @params id Integer код комитера
  # @result File
  def self.pdf(id)
    return unless (cmtr = Committer.find_by(id: id.to_i))

    Prawn::Document.generate(r = "#{DIR}/award_#{cmtr.stock}_#{cmtr.author}_#{cmtr.place}.pdf") do
      move_down(200)
      text "PDF ##{cmtr.place}", align: :center, size: 48

      move_down(40)
      text 'The awards goes to', align: :center, size: 32

      move_down(40)
      text cmtr.author, align: :center, size: 24
    end
    r
  end

  require 'zip'

  # упаковать файлы дипломов комитеров в zip
  # @params ActiveRecord::Relation список записей
  # @return String имя файла архива
  def self.to_zip(cmtrs, params)
    return if cmtrs.blank?
    return if params[:id].blank?

    input_filenames = cmtrs.inject([]) { |sum, cmtr| sum << Committer.pdf(cmtr.id) }

    zipfile_name = "#{DIR}/awards_#{params[:id]}.zip"
    File.unlink(zipfile_name) if File.file?(zipfile_name)

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      input_filenames.each do |filename|
        zipfile.add(File.basename(filename), filename)
      end
    end
    zipfile_name
  end

  # очистка временных файлов
  def self.zap
    FileUtils.rm_rf("#{DIR}/.", secure: true)
  end

  # запись комитеров в таблицу БД
  # старые по этому репо удаляются
  private_class_method def self.committers_2table(committers, url)
    Committer.where(repo: url).delete_all
    ids = committers_create(committers, url)
    Committer.where(stock: ids[0])
  end

  # создание записей в таблице БД по переданным комитерам
  private_class_method def self.committers_create(committers, url)
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
