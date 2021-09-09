module Skylark
  module Tools
    module_function
    def run
      flag = true
      page = 0
      while flag
        responses = skylark_service.query_form_responses(VaccinationForm.form_id,page += 1)

        flag = false if responses.headers[:x_slp_total_pages].to_i == page

        JSON.parse(responses).each do |response|
          vaccination_form = VaccinationForm.find_by(response_id: responses['id'])         
          if vaccination_form.company != responses['mapped_values']['company']['text_value'].join()
            vaccination_form.company = responses['mapped_values']['company']['text_value'].join()
            vaccination_form.update(company: vaccination_form.company)
          elsif vaccination_form.number != responses['mapped_values']['number']['text_value'].join()
            vaccination_form.number = responses['mapped_values']['number']['text_value'].join()
            vaccination_form.update(number: vvaccination_form.number)
          elsif vaccination_form.nonumber = responses['mapped_values']['nonumber']['text_value'].join()
            vaccination_form.nonumber = responses['mapped_values']['nonumber']['text_value'].join()
            vaccination_form.update(nonumber: vaccination_form.nonumber)
          elsif vaccination_form.name = responses['mapped_values']['name']['text_value'].join()
            vaccination_form.name = responses['mapped_values']['name']['text_value'].join()
            vaccination_form.update(name: vaccination_form.name)         
          elsif vaccination_form.phone = responses['mapped_values']['phone']['text_value'].join().to_i
            vaccination_form.phone = responses['mapped_values']['phone']['text_value'].join().to_i
            vaccination_form.update(phone: vaccination_form.phone)
        end
      end
    end

    private
 
    def skylark_service
      @skylark_service ||= SkylarkService.new 
    end
  end
end
