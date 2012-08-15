namespace :publinator do
  desc "Dump DB, then repopulate it."
  task :repopulate => :environment do
    ["db:drop", "db:create", "db:migrate", "publinator:install:migrations", "db:seed"].each do |t|
      Rake::Task[t].execute
      `touch tmp/restart.txt`
    end
  end
end