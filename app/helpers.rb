# Helpers

def link_to(path,label)
  "<a href=\"#{path}\">#{label}</a>" 
end

def post_path(post,label)
  link_to "/post/#{post.date.strftime("%Y-%m-%d")}/#{post.permalink}", label
end

def pages(neighbours = 3)
  right = ((@current_page + neighbours) < Post.page_count) ? @current_page + neighbours : Post.page_count
  left =  (@current_page > neighbours) ? @current_page - neighbours : 1
  middle = (left..right).to_a.map do |i|
    if i == @current_page
      "<b>"+link_to("/posts?p=#{i}", i)+"</b>"
    else
      link_to "/posts?p=#{i}", i
    end
  end
  middle = left_arrows + middle if @current_page > 1
  middle = middle + right_arrows if @current_page < Post.page_count
  middle.join('')
end

def left_arrows
  [ link_to("/posts?p=#{@current_page-1}", "&laquo; Prev") ]
end

def right_arrows
  [ link_to("/posts?p=#{@current_page+1}", "Next &raquo;") ]
end
