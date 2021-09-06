class VaccinationFormsController < ApplicationController
  skip_before_action :verify_authenticity_token 
  before_action :get_action 
  layout false
  def receive
    
    if @action == 'created'

      form = VaccinationForm.new(
        company:  params['response']['mapped_values']['company']['text_value'].join(),
        number: params['response']['mapped_values']['number']['text_value'].join(),
        nonumber: params['response']['mapped_values']['nonumber']['text_value'].join(),
        name: params['response']['mapped_values']['name']['text_value'].join(),
        phone: params['response']['mapped_values']['phone']['text_value'].join().to_i
      )
      form.save
    elsif @action == 'updated'
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
    elsif @action == 'destroyed'
      form = VaccinationForm.find_by(response_id: params['response']['id'])
      unless form.nil?
        form.destroy
      end
    end
    head :ok 
  end

  private
  def get_action
    @action = request.request_parameters['action']
  end
end
