require "mail"

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      m = Mail::Address.new(value)
      r = m.domain != nil && m.domain.match("\.") && m.address == value
    rescue Exception => e
      r = false
    end
    record.errors[attribute] << (options[:message] || "is not a valid email") unless r
    record.errors[attribute] << "must be given, Please give us a real one" unless value !~ User::TMP_EMAIL_REGEX
  end
end
    