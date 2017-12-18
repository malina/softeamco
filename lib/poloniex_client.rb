class PoloniexClient < BaseClient
  def host
    'https://poloniex.com'
  end

  def currencies
    get('public?command=returnCurrencies')
  end
end
