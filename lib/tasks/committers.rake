# работа с комитерами
namespace :committers do
  desc 'zap - очистка временных файлов и записей'
  task zap: :environment do |t, args|
    Committer.zap
  end
end
