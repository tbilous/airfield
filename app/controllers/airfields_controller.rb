class AirfieldsController < ApplicationController
  include Plainable

  def show; end

  def init
    Plain.init
    render_plains
  end
end
