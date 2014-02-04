options = { :namespace => "minimus_#{ENV['RACK_ENV']}", :compress => true }
DC = Dalli::Client.new('localhost:11211', options)
