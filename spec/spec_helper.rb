require 'rspec'
require 'open3'
require 'timeout'
require 'pty'

ROOT_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..'))

$LOAD_PATH.unshift File.join(ROOT_DIR, 'lib')
require "margs/util"

RSpec.configure do |config|
  config.disable_monkey_patching!
end

def bin(file, *args, stdin: nil, timeout: 3)
  executable = File.join(ROOT_DIR, 'bin', file)
  raise ArgumentError, "no executable named #{file}" if !File.exists?(executable)
  opts = {}
  if !stdin
    pty_in, pty_out = PTY.open
    opts[:in] = pty_out
    opts[:out] = pty_in
  end
  Open3.popen3(executable, *args, opts) do |p_stdin, p_stdout, p_stderr, wait_thread|
    if stdin
      p_stdin.puts stdin
      p_stdin.close
    end


    begin
      Timeout.timeout(timeout) do
        if wait_thread.value.success?
          p_stdout.read
        else
          raise "executable failed: #{wait_thread.value}, stderr=#{p_stderr.read}"
        end
      end
    rescue Timeout::Error => e
      Process.kill("KILL", wait_thread.pid)
      raise e
    end
  end
ensure
  pty_in && pty_in.close
  pty_out && pty_out.close
end
