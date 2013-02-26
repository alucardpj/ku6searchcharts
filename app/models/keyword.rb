class Keyword
  include Mongoid::Document

  field :keyword, type: String
  field :count, type: Integer
  field :date, type: String
end
