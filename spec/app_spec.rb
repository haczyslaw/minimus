require File.expand_path('../spec_helper.rb',__FILE__)

describe 'Blog' do
  before do
    permalink = Post.all.first.permalink
    @post = Post.find(permalink) # load from memcache
  end

  it 'should have latest posts on index page' do
    get '/'
    last_response.must_be :ok?
    last_response.body.must_include @post.title
  end

  it 'should have post body on show post action' do
    get "/post/#{@post.date.strftime("%Y-%m-%d")}/#{@post.permalink}"
    last_response.must_be :ok?
    last_response.body.must_include @post.body
  end

  it 'should receive msg not found on inccorect link' do
    get "/post/#{@post.date.strftime("%Y-%m-%d")}/not-found-0"
    last_response.must_be :ok?
    last_response.body.must_include 'Post not found'
  end
end
