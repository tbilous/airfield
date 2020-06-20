class PlainHistory
  include Mongoid::Document

  field :state, type: String
  field :created_at, type: DateTime

  belongs_to :plain
end
