class Message
  def self.not_found(record = 'record')
    I18n.t('message.record_not_found', record_id: record)
  end

  def self.invalid_credentials
    I18n.t('message.invalid_credentials')
  end

  def self.invalid_token
    I18n.t('message.invalid_token')
  end

  def self.missing_token
    I18n.t('message.missing_token')
  end

  def self.unauthorized
    I18n.t('message.unauthorized_request')
  end

  def self.account_created
    I18n.t('message.account_created')
  end

  def self.account_not_created
    I18n.t('message.account_could_not_created')
  end

  def self.expired_token
    I18n.t('message.expired_token')
  end
end
