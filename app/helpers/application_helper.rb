module ApplicationHelper
    def gravatar_for(user,options={size: 100})
      email_address = user.email.downcase
      hash = Digest::MD5.hexdigest(email_address)
      size = options[:size]
      gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
      image_tag(gravatar_url,alt:user.username, class: "rounded shadow mx-auto d-block")
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
      # ||= is used for memoization of @current_user variable
    end

    def logged_in?
      !!current_user #here !! converts @current_user into boolean
    end
end
