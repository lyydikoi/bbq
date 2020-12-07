module ApplicationHelper

  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      "https://robohash.org/#{user.name}"
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      "https://robohash.org/#{user.name}"
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def event_photo(event)
    photos = event.photos.persisted
  
    if photos.any?
      photos.sample.photo.url
    else
      asset_path('event.jpg')
    end
  end
  
  def event_thumb(event)
    photos = event.photos.persisted
  
    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_path('event_thumb.jpg')
    end
  end
  
end
