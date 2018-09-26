# отдача zip с дипломами репозитория
class ZipController < ApplicationController

  def show
    stock = params[:id].to_i
    cmtrs = Committer.where(stock: stock)
    return back(alert: 'ошибка получения zip') if cmtrs.blank?

    zipfile_name = Committer.to_zip(cmtrs, params)
    send_file zipfile_name, type: 'application/zip', disposition: 'attachment'
  end
end
