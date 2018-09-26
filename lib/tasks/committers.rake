# работа с комитерами
namespace :committers do
  desc 'zap - очистка временных файлов'
  task zap: :environment do |t, args|
    Committer.zap
  end
end
