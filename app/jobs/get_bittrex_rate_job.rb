class GetBittrexRateJob < ApplicationJob
  def perform
    client = BittrexClient.new
    source = Source.find_by(name: 'bittrex')

    summaries = client.marketsummaries

    now = Time.now
    values = []
    summaries.each do |summary|
      high = summary.dig('High')
      low = summary.dig('Low')
      bid = summary.dig('Bid')
      ask = summary.dig('Ask')
      last = summary.dig('Last')
      pare = summary.dig('MarketName')
      source_id = source.id
      created_at = now
      updated_at = now
      value = "(#{high}, #{low}, #{bid}, #{ask}, #{last}, '#{pare}', #{source_id}, '#{created_at}', '#{updated_at}')"
      values.push(value)
    end
    sql = %Q{
      INSERT INTO rates (high, low, bid, ask, last, pare, source_id, created_at, updated_at)
      VALUES #{values.join(', ')}
      ON CONFLICT (pare) DO UPDATE
        SET high = excluded.high,
            low = excluded.low,
            bid = excluded.bid,
            ask = excluded.ask,
            updated_at = excluded.updated_at,
            last = excluded.last;
    }
    Rate.connection.execute sql
  end

  def slow_method
    client = BittrexClient.new
    source = Source.find_by(name: 'bittrex')

    summaries = client.marketsummaries

    summaries.each do |summary|
      attributes = {
        high: summary.dig('High'),
        low: summary.dig('Low'),
        bid: summary.dig('Bid'),
        ask: summary.dig('Ask'),
        last: summary.dig('Last')
      }
      rate = source.rates.find_or_initialize_by(pare: summary.dig('MarketName'))

      rate.assign_attributes(attributes)
      rate.save
    end
  end
end
