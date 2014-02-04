# encoding: utf-8

class Posts < Minimus::Controller
  def index
    @current_page = get_page(params['p'].to_i)
    @posts = Post.page @current_page
    render 'index'
  end

  def show
    @permalink = @env['PATH_INFO'].split("/").last
    @post = Post.find(@permalink)
    if @post
      render 'show'
    else
      render 'not_found'
    end
  end

  private

  def get_page(number)
    (number < 1) ? 1 : number
  end
end
