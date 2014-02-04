# encoding: utf-8

module Minimus
  class Controller
    attr_reader :params

    def initialize(env)
      @env=env
      @params = Rack::Request.new(@env).params
    end

    def render(view, opts= {status_code: 200, headers: {"Content-Type" => 'text/html'}, engine: :erubis})
      if opts[:engine] == :erubis # ToDo: add more engines ;)
        input = File.read(APP_VIEWS+"/#{self.class.to_s.downcase}/#{view}.html.erb")
        eruby = Erubis::Eruby.new(input)
        body = eruby.result(binding())
      end
      # ToDo: add caching
      yield(body) if block_given?
      [opts[:status_code],opts[:headers],[body]]
    end

  end

  class Router
    def initialize(routes_map)
      formatted = {}
      routes_map.each do |k,v|
        formatted[k] = format_route(v)
      end
      @@app = Rack::URLMap.new(formatted)
    end

    def format_route(r)
      items = r.split('#')
      cls = Kernel.const_get(items[0].capitalize)
      Proc.new {|env| cls.new(env).send(items[1].to_sym) }
    end

    def self.app
      @@app
    end
  end

end
