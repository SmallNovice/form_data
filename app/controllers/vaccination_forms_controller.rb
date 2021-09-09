class VaccinationFormsController < ApplicationController
  skip_before_action :verify_authenticity_token 
  before_action :set_action

  def receive
    case @response_action
    when 'created'
      form = VaccinationForm.new(
        response_id: params['response']['id'],
        company:  params['response']['mapped_values']['company']['text_value'].join(),
        number: params['response']['mapped_values']['number']['text_value'].join(),
        nonumber: params['response']['mapped_values']['nonumber']['text_value'].join(),
        name: params['response']['mapped_values']['name']['text_value'].join(),
        phone: params['response']['mapped_values']['phone']['text_value'].join().to_i
      )
      form.save
    when 'updated'
      form = VaccinationForm.find_by(response_id: params['response']['id'])
      unless form.nil?
        form.update(
          company:  params['response']['mapped_values']['company']['text_value'].join(),
          number: params['response']['mapped_values']['number']['text_value'].join(),
          nonumber: params['response']['mapped_values']['nonumber']['text_value'].join(),
          name: params['response']['mapped_values']['name']['text_value'].join(),
          phone: params['response']['mapped_values']['phone']['text_value'].join().to_i
        )
      end
    when 'destroyed'
      form = VaccinationForm.find_by(response_id: params['response']['id'])
      unless form.nil?
        form.destroy
      end
    end
    head :ok 
  end

  private

  def set_action
    @response_action = request.request_parameters['action']
  end
end
