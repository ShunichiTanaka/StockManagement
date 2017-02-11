class Quandls
  def initialize(brand = nil)
    @brand = brand
  end

  def quandl_client
    Quandl::ApiConfig.api_key = ''
    Quandl::ApiConfig.api_version = ''
  end

  # 銘柄情報の取得
  def receive_stock_info
    Quandl::Dataset.get("TSE/#{@brand.code}").data(params: {limit:100})
  end

  # TOPページの株式情報取得
  def receive_info
    nikkei_average = Quandl::Dataset.get("NIKKEI/INDEX").data(params: { limit:150 })
    jasdaq_average = Quandl::Dataset.get("NIKKEI/JASDAQ").data(params: { limit:150 })
    return nikkei_average, jasdaq_average
  end
end
