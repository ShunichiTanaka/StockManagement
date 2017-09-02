class Admin::StockAnalysesController < ApplicationController
  def index
  end

  def analysis
    # csvファイルの取り込み
    csv_file = params[:file]
    if csv_file.present?
      target_date = csv_file.original_filename.match(/\d{4}-\d{2}-\d{2}/)[0].to_date
      data = CSV.read(params[:file].path, encoding: "Shift_JIS:UTF-8")[253..-1]
      StockPrice.data_import(data, target_date)
    end

    # 最新の日付
    target_today = StockPrice.from_current_day(1)
    # ７日間
    short_target_range = StockPrice.from_current_day(7)
    # １３日間
    medium_target_range = StockPrice.from_current_day(13)
    # ２５日間
    long_target_range = StockPrice.from_current_day(25)
    # 前日
    target_yesterday = StockPrice.from_previous_day(1)
    # 前日から７日間
    pre_short_target_range = StockPrice.from_previous_day(7)
    # 前日から１３日間
    pre_medium_target_range = StockPrice.from_previous_day(13)

    # 短期の銘柄別平均
    short_stock_summary = StockPrice.summary(short_target_range)
    # 中期の銘柄別平均
    medium_stock_summary = StockPrice.summary(medium_target_range)
    # 長期の銘柄別平均
    long_stock_summary = StockPrice.summary(long_target_range)
    # 当日の終値
    today_stock_summary = StockPrice.where(target_date: target_today)
    # 前日の終値
    yesterday_stock_summary = StockPrice.where(target_date: target_yesterday)
    # 前日までの短期
    pre_short_stock_summary = StockPrice.summary(pre_short_target_range)
    # 前日までの中期
    pre_medium_stock_summary = StockPrice.summary(pre_medium_target_range)

    brands = Brand.all
    deviration_data = []
    brands.each do |b|
      if medium_stock_summary[b.code].present? && short_stock_summary[b.code].present? && long_stock_summary[b.code].present? &&
         pre_medium_stock_summary[b.code].present? && pre_short_stock_summary[b.code].present?

        pre_deviration = (pre_medium_stock_summary[b.code] - pre_short_stock_summary[b.code]) / pre_short_stock_summary[b.code] * 100
        deviration = (medium_stock_summary[b.code] - short_stock_summary[b.code]) / short_stock_summary[b.code] * 100
        deviration_for_short = (long_stock_summary[b.code] - short_stock_summary[b.code]) / short_stock_summary[b.code] * 100
        if deviration_for_short > 2.5
          today_stock = today_stock_summary.find { |d| d.code == b.code }
          today_price = if today_stock.present?
                          today_stock.close
                        else
                          99_999
                        end
          yesterday_stock = yesterday_stock_summary.find_by(code: b.code)
          pre_ratio = if today_stock.present? && yesterday_stock.present?
                        today_stock.close - yesterday_stock.close
                      else
                        0
                      end
          rate_change = deviration < pre_deviration ? "color: #0f0" : "color: #f00"
          deviration_data << { code: b.code, name: b.name, deviration: deviration, price: today_price, pre_ratio: pre_ratio, rate_up: rate_change }
        end
      end
    end
    StockMailer.send_stock_data(deviration_data).deliver
    redirect_to action: "index"
  end

  def import_index
    csv_file = params[:file]
    if csv_file.present?
      target_date = csv_file.original_filename.match(/\d{4}-\d{2}-\d{2}/)[0].to_date
      unless StockIndex.exists?(target_date: target_date)
        data = CSV.read(params[:file].path, encoding: "Shift_JIS:UTF-8")
        StockIndex.data_import(data, target_date)
      end
    end
    redirect_to action: "index"
  end
end
