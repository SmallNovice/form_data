class CompareData
    flag = true
    page = 0

    while flag
      responses = SkylarkService.new.query_form_responses(VaccinationForm.form_id,page += 1)

      flag = false if responses.headers[:x_slp_total_pages].to_i == page

      ActiveRecord::Base.transaction do
        JSON.parse(responses).each do |response|
            VaccinationForm.upsert(response)
        end
      end
    end
end

