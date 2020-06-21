class Plain
  include Mongoid::Document
  include Flyable

  has_many :plain_histories, dependent: :destroy

  after_create :write_history

  validates_inclusion_of :state, in: ::Options::Plain::States.all, allow_blank: false

  ::Options::Plain::States.all.each do |state|
    define_method "#{state}!" do
      update_state!(state)
    end
  end

  def self.states
    ::Options::Plain::States.all
  end

  def self.init
    5.times do
      create
    end
  end

  private

  def update_state!(state)
    update!(state: state)
  end

  def write_history
    plain_histories.create(state: state)
  end
end
