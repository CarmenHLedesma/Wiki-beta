module UsersHelper
  def user_show_breadcrumb (user)
    while user.name.present?
      navigation_add @user.name, user_path(user)
      user = user.name
    end
  end
end
