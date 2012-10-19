namespace :publinator do
  desc "Dump DB, then repopulate it."
  task :repopulate => :environment do
    ["db:drop", "publinator:install:migrations", "db:create", "db:migrate", "db:seed"].each do |t|
      Rake::Task[t].execute
      `touch tmp/restart.txt`
    end
  end
end
