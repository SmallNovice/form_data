class SkylarkService
	attr_reader :appid, :appsecret, :namespace_id, :host

	def initialize
    @namespace_id = 14
    @appid = '1818e888554137be28504ea8619b6dd853009b93177e2e78c87922cb5c0d0591'
    @appsecret = '4fd078c9fef8ee0f1311e2d1661619c5b87ed9749b038ded3e52d576cfec1fb9'
    @host = 'https://skylarkly.com/'
  end

  def query_form_responses(form_id, page = 1, per_page = 24)
    RestClient::Request.execute(
      method: :get,
      url: query_form_responses_url(form_id, page, per_page),
      headers: authorization_token,
      timeout: 20
    )
  end

  def query_response(response_id)
    RestClient::Request.execute(
      method: :get,
      url: query_response_url(response_id),
      headers: authorization_token,
      timeout: 20
    )
  end

	private

  def query_form_responses_url(form_id, page, per_page)
  	"#{@host}/api/v4/mapper/responses?form_id=#{form_id}&page=#{page}&per_page=#{per_page}"
  end

	def authorization_token
    { Authorization: "#{@appid}:#{encode_secret}" }
  end

  def encode_secret
    JWT.encode(
      {
        'namespace_id': @namespace_id,
      },
      @appsecret,
      'HS256',
      typ: 'JWT', alg: 'HS256'
    )
  end

  def query_response_url(response_id)
    @host + "/api/v4/responses/#{response_id}"
  end
end
