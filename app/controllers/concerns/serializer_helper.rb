module SerializerHelper
  def date_created
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def date_modified
    object.updated_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def created_by
    object.user.firstname
  end

  def message
    "You can access your Do! account by logging in with '#{object.email}'"\
    " and your password"
  end
end
