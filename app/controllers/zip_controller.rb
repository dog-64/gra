# отдача zip с дипломами репозитория
class ZipController < ApplicationController
  require 'zip'

  def show
    stock = params[:id].to_i
    cmtrs = Committer.where(stock: params[:id])
    return back(alert: 'ошибка получения zip') if cmtrs.blank?

    input_filenames = cmtrs.inject([]) { |sum, cmtr| sum << Committer.pdf(cmtr.id) }

    zipfile_name = "tmp/awards_#{params[:id]}.zip"
    File.unlink(zipfile_name) if File.file?(zipfile_name)

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      input_filenames.each do |filename|
        zipfile.add(filename, filename)
      end
    end

    send_file zipfile_name, type: 'application/zip', disposition: 'attachment'
  end

end
