# отдача pdf с дипломами репозитория
class PdfController < ApplicationController

  def show
    return back(alert: 'ошибка получения pdf') unless (file_name = Committer.pdf(params[:id]))
    send_file file_name, type: 'application/pdf'
  end

end
