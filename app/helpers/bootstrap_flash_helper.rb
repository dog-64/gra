# -*- encoding : utf-8 -*-
# для борьбы с ошибкой ActionView::Template::Error (undefined local variable or method `bootstrap_flash'
# https://github.com/seyhunak/twitter-bootstrap-rails/blob/master/app/helpers/bootstrap_flash_helper.rb
module BootstrapFlashHelper
  def bootstrap_flash_js
   flash_messages = ['<script type="text/javascript">',
                     # '(function () {'
                     '$(function () {'
   ]
   flash.each do |type, message|
     type = :success if type.to_sym == :notice
     type = :error   if type.to_sym == :alert
     # flash_messages << "purr_msg('#{message}')" if message
     flash_messages << "$.jGrowl('#{message}')" if message
   end

   flash_messages << [
       '})',
       # '})(jQuery);',
       '</script>']
   flash_messages.join("\n").html_safe
  end

  def bootstrap_flash
   flash_messages = []
   flash.each do |type, message|
     type = :success if type.to_sym == :notice
     type = :error   if type.to_sym == :alert
     text = content_tag(:div,
              content_tag(:button, raw("&times;"), class: 'close', 'data-dismiss' => 'alert') +
              # message, class: "alert fade in alert-#{type}")
              message, class: "alert in alert-#{type}")
     flash_messages << text if message
   end

   flash_messages << []
   flash_messages.join("\n").html_safe
  end

end