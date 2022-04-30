# frozen_string_literal: true

spec = proc do |pattern|
  system "#{FileUtils::RUBY} -e 'ARGV.each{|f| require f}' #{pattern}"
end

desc 'Run specs'
task :default do
  spec.call('./*_spec.rb')
end
