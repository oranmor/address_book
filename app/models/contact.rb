class Contact < ActiveRecord::Base
  ARRAY_DELIMITER = ';'

  validates :first_name, :last_name, presence: true
  validates :emails, presence: true, if: ->(contact) { contact.phones.blank? }
  validates :phones, presence: true, if: ->(contact) { contact.emails.blank? }
  validates :first_name, uniqueness: { scope: :last_name }

  scope :search, ->(str) {
    where("first_name ILIKE :str OR
           last_name ILIKE :str OR
           :str ILIKE ANY (emails) OR
           :str ILIKE ANY (phones)", str: str)
  }

  def name
    "#{first_name} #{last_name}"
  end

  %i(phones= emails=).each do |method|
    define_method(method) do |values|
      values = values.split(ARRAY_DELIMITER) if values.is_a?(String)
      values ||= []
      super(values.reject(&:blank?))
    end
  end
end
