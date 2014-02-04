# encoding: utf-8

class Post
  attr_reader :title, :date, :body, :permalink

  PER_PAGE = 5
  POSTS_DIR = "/posts/**/*.yml"
  FIXTURES_DIR = "/spec/fixtures/**/*.yml"

  def initialize(item,opts = {autosave: false, body: false})
    item['date'] = item['date'].is_a?(String) ? Time.parse(item['date']) : item['date'].to_time
    @title, @date = item['title'], item['date']
    item['permalink'] ||= item['title'].to_ascii.downcase.gsub(/\s/,'-').gsub(/[^a-z0-9\-]/,'')
    @permalink = item['permalink']
    # Similar to ActiveRecord create
    DC.set(@permalink,item.to_json) if opts[:autosave]
    # Protecting from creating instance variable body
    @body = item['body'] if opts[:body]
    self
  end

  class << self

    def prepare
      load_all unless defined?(@@posts)
    end

    def posts_dir 
      (ENV['RACK_ENV'] == 'test') ? FIXTURES_DIR : POSTS_DIR
    end

    def load_all
      @@posts = []
      Dir[APP_ROOT + posts_dir ].each do |file|
        @@posts << self.new(YAML::load_file(file),autosave: true) 
      end
      @@posts.sort_by!{|t| -(t.date.to_i)}
    end

    def all
      @@posts
    end
    
    def find(permalink)
      item = DC.get(permalink)
      item ? self.new(JSON.parse(item),body: true) : nil
    end

    def page(number, opts = {body: false})
      items = @@posts[PER_PAGE*(number-1)...PER_PAGE*number]
      opts[:body] ? items.map{|i| find(i.permalink)} : items
    end

    def count
      @@posts.length
    end

    def page_count
      (count.to_f / PER_PAGE.to_f).ceil
    end

  end

end

Post.prepare
