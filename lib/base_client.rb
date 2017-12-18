require 'faraday'
require 'json'

class BaseClient
  def host; end
  def get(path, params = {}, headers = {})
    response = connection.get do |req|
      url = "#{host}/#{path}"
      req.params.merge!(params)
      p url
      req.url(url)
    end

    JSON.parse(response.body)['result']
  end

  private

  def connection
    @connection ||= Faraday.new(:url => host) do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter
    end
  end
end
