module Plainable
  extend ActiveSupport::Concern

  included do
    private

    def render_plains
      render json: { plains: Plain.all.map(&:broadcast_serialize) }
    end
  end
end
