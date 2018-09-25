# операции с хешами
# {x:1}+{y:2} = {:x=>1, :y=>2}
#
# http://strugglingwithruby.blogspot.ru/2010/04/operator-overloading.html
# require 'hash_extension.rb'

class Hash

  def +(y)
    self.merge(y)
  end

  # взятие вложенных элементов без ошибки
  # http://stackoverflow.com/questions/6224875/equivalent-of-try-for-a-hash-to-avoid-undefined-method-errors-on-nil
  # hash.gt(:a, :b)
  def gt(*fields)
    fields.inject(self) { |acc, e| acc[e] if acc }
  end
end