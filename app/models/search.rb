class Search
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :q, :from, :to

  validates_presence_of :q
  validates_presence_of :from
  validates_presence_of :to
  validate :date_validation

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  private
  def date_validation
    if from > to
      errors.add :from, I18n.t("validation.date_error")
    end
  end
end