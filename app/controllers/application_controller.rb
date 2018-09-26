class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # возврат на предыдущую страницу
  # а если не получилось на главную админскую
  # пример
  # return back(alert: '123')
  # @params option Hash аргументы для redirect_back
  def back(options)
    redirect_back(fallback_location: root_path, **options)
  end

  # сообщение об ошибке и переход к индексу контроллера
  # @params msg String сообщение об ошибке
  # пример
  # return err('Проблема регистрации') if !@firm.save
  def err(msg, path = admin_firms_url)
    redirect_to path, alert: msg
  end

  # сообщение и переход к индексу контроллера
  # @params msg String сообщение
  # пример
  # return ok('Регистрация получена') if @firm.save
  def ok(msg, path = {action: :index})
    redirect_to path, notice: msg
  end

end
