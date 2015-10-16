require 'standalone_migrations'
require 'rake/testtask'

StandaloneMigrations::Tasks.load_tasks

Rake::TestTask.new do |t|
  t.libs << ["spec", "helpers", "models" ]
  t.pattern = "spec/**/*_spec.rb"
  t.verbose = true
end

