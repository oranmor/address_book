class Contact < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  validates :emails, presence: true, if: ->(contact) { contact.phones.blank? }
  validates :phones, presence: true, if: ->(contact) { contact.emails.blank? }
  validates :first_name, uniqueness: { scope: :last_name }

  def phones=(vals)
    vals ||= []
    super(vals.reject(&:blank?))
  end

  def emails=(vals)
    vals ||= []
    super(vals.reject(&:blank?))
  end
end
