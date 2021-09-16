class VaccinationFormsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_action

  def receive
    case @response_action
    when 'created', 'updated'
      VaccinationForm.upsert(params['response'].permit!)
    when 'destroyed'
      response = VaccinationForm.find_by(response_id: params['response']['id'])
      response.destroy if response
    end
    head :ok
  end

  private

  def set_action
    @response_action = request.request_parameters['action']
  end
end
