require 'pty'
require 'open3'

pty_in, pty_out = PTY.open

i, o, e, w = Open3.popen3('ruby', 'pty.rb', :in => pty_in)

w.value
puts o.read
