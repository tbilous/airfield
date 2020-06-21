class PlainsController < ApplicationController
  include Plainable

  def index
    render_plains
  end

  def take_off
    @plain = Plain.find_by(id: strong_params[:plain_id])
    if @plain.taxiway
      render json: @plain, status: 201
    else
      render json: @plain, status: :forbidden
    end
  end

  private

  def strong_params
    params.permit(:plain_id)
  end
end
