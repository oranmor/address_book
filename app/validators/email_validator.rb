class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value = [value] unless value.is_a?(Array)
    value.each do |email|
      unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        record.errors[attribute] << (options[:message] || I18n.t('errors.messages.not_email'))
      end
    end
  end
end
