module PostsHelper

  def post_show_breadcrumb (post)
    while post.parent.present?
      navigation_add post.parent.title, post_path(post.parent)
      post = post.parent
    end
  end
end
