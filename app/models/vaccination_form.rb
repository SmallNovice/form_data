class VaccinationForm < ApplicationRecord
  def self.upsert(params)
    response_id = params['id']

    response_attributes = {
      response_id: response_id,
      company: params.dig('mapped_values', 'company', 'text_value', 0),
      number: params.dig('mapped_values', 'number', 'text_value', 0),
      nonumber: params.dig('mapped_values', 'nonumber', 'text_value', 0),
      name: params.dig('mapped_values', 'name', 'text_value', 0),
      phone: params.dig('mapped_values', 'phone', 'text_value', 0).to_i
    }

    if response = VaccinationForm.find_by(response_id: params['id'])
      response.update(response_attributes)
    else
      VaccinationForm.create(response_attributes)
    end
  end

  def self.delete(array)
    flag_delete = true
    data_index = 1

    while flag_delete
      flag_delete = false if data_index == VaccinationForm.last.id
      vacc = VaccinationForm.find_by(id: data_index)
      if vacc && (([vacc.response_id] & array).empty?)
        vacc.destroy
      end
      data_index += 1
    end
  end

  private

  def self.form_id
    form_id = 13050
  end
end
