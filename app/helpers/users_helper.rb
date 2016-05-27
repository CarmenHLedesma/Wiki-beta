module UsersHelper
  def user_show_breadcrumb (user)
    while user.present?
      navigation_add @user, user_path(user)
      @user = user.name
    end
  end
end
