class VaccinationForm < ApplicationRecord
	def self.build(values)
			form = VaccinationForm.new(
      response_id: values['id'],   
			company:	values['mapped_values']['company']['text_value'].join(),
			number: values['mapped_values']['number']['text_value'].join(),
			nonumber: values['mapped_values']['nonumber']['text_value'].join(),
			name: values['mapped_values']['name']['text_value'].join(),
			phone: values['mapped_values']['phone']['text_value'].join().to_i)	
  end

   private

  def self.form_id
   	form_id = 13050
  end

end