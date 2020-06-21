class PlainHistory
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :state, type: String

  belongs_to :plain
end
