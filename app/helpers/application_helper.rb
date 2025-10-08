module ApplicationHelper
  def role_is_user?
    current_user.role == "user"
  end

  def role_is_leader?
    current_user.role == "leader"
  end

  def role_is_admin?
    current_user.role == "admin"
  end
end
