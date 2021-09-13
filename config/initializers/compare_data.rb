class CompareData
    flag_create_and_update = true
    page = 0
    array = []
    array_index = 0
    len = VaccinationForm.last.id
    data_index = 1
    flag_delete = true
    response_id = []

    while flag_create_and_update
      responses = SkylarkService.new.query_form_responses(VaccinationForm.form_id,page += 1)

      flag_create_and_update = false if responses.headers[:x_slp_total_pages].to_i == page

      ActiveRecord::Base.transaction do
        JSON.parse(responses).each do |response|
          array[array_index] = response['id']
          array_index += 1
          VaccinationForm.upsert(response)
        end
      end
    end

    while flag_delete
      flag_delete = false if data_index == len
      if vacc = VaccinationForm.find_by(id: data_index)

        response_id = [vacc.response_id]

        if (response_id & array).empty?
          vacc.destroy
        end
      end
      data_index += 1
    end
end

