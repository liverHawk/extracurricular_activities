module OAuthPolicy
  attr_reader :provider, :uid, :name, :nickname, :email, :url, image_url, :description, :other, :credentails, :raw_info

  class GitHub < OAuthPolicy::Base
    def initialize(auth)
      @provider = :github
      @uid = credentials[:uid]
      @email = raw_info[:email]
      @image_url = raw_info[:user][:avatar_url]
      freeze
    end
  end
end