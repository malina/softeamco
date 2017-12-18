class BittrexClient < BaseClient
  def host
    'https://bittrex.com/api/v1.1'
  end

  def currencies
    get('public/getcurrencies')
  end
  
  def marketsummaries
    get('public/getmarketsummaries')
  end
end
