require 'unicorn/oob_gc'
 
# this should probably be between CPU threads and CPU threads * 2
worker_processes 2
 
# this is your current deployed code symlink
root = "/home/ubuntu/apps/ubiquity"
working_directory root
 
 
# don't use TCP to talk to Nginx
listen "/tmp/unicorn.ubiquity.sock"
 
# how long is it ok for your workers to hang
timeout 30
 
pid "#{root}/tmp/pids/unicorn.pid"
 
stderr_path "#{root}/log/unicorn_stderr.log"
stdout_path "#{root}/log/unicorn_stdout.log"
 
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true
 
check_client_connection false
 
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{root}/Gemfile"
end
 
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
  
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end
 
after_fork do |server, worker|
 
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end
  
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
