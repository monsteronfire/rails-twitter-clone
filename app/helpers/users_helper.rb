module UsersHelper
  # Returns the Gravatr for the given user.
  def gravatar_for(user, size: 50)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?2=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
