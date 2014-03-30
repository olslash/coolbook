module SessionsHelper
  def sign_in(user)
    #a new token is created each sign-in
    #create a new remember token
    remember_token = User.new_remember_token

    #place the raw token into users browser cookies
    #cookies are manipulated like hashes
    cookies.permanent[:remember_token] = remember_token

    # save the hashed token to the db, bypassing validations (because we don't have password
    # and confirmation, which would be needed to pass thru the model)
    hashed_token = User.hash(remember_token)
    user.update_attribute(:remember_token, hashed_token)

    self.current_user = user

  end

  def sign_out
    #create a new remember token so the old one can't be reused to authorize
    current_user.update_attribute(:remember_token,
                                  User.hash(User.new_remember_token))
    #delete the remember token cookie
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    #a function to get the current user

    #lookup the user's remember token cookie, and hash it.
    hashed_token = User.hash(cookies[:remember_token])
    # look for a user matching the hashed token, if a current user
    # is not already set. so we aren't always hitting the db.
    @current_user ||= User.find_user_by_token(hashed_token) #User.find_by(remember_token: hashed_token)
  end
end
