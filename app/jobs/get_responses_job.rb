class GetResponsesJob < ApplicationJob
	queue_as :default

	def perform()
		flag = true
		page = 0
		while flag
			responses = skylark_service.query_form_responses(VaccinationForm.form_id,page += 1)
			
			flag = false if responses.headers[:x_slp_total_pages].to_i == page

			ActiveRecord::Base.transaction do
				JSON.parse(responses).each do |response|
					VaccinationForm.build(response).save
				end
			end
		end
	end

	private
 
	def skylark_service
		@skylark_service ||= SkylarkService.new 
	end
end