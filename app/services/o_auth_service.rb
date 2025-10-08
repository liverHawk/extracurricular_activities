module OAuthService
  class GetOAuthUser
    def self.call(auth)
      user = current_or_profile_user(auth)

      unless user
        # TODO: Add email verification
        email = email_from_auth(auth)
        user = User.where(email: email).first if email
        user ||= find_or_create_by_auth(auth)
      end
      user
    end

    private

    class << self
      def current_or_profile_user(auth)
        user = User.current_user.presence
      end

      def verified_email_from_auth(auth)
        auth.info.email if auth.info.email && (auth.info.verified || auth.info.verified_email)
      end

      def email_from_auth(auth)
        auth.info.email if auth.info.email
      end

      def find_or_create_by_auth(auth)
        email = email_from_auth(auth)
        puts "email: #{email}"
        user = User.where(email: email).first if email
        if user.nil?
          temp_email = "#{User::TMP_EMAIL_REPREFIX}-#{auth.uid}-#{auth.provider}.com"
          user = User.new(
            email: email ? email : temp_email,
            password: Devise.friendly_token[0, 20]
          )
          user.skip_confirmation!
          user.save(validate: false)
          user
        end
      end
    end
  end
end