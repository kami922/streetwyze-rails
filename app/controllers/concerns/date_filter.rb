# frozen_string_literal: true

# handle date filter functions//index model calls this module
module DateFilter
  extend ActiveSupport::Concern

  private

  def filter_date_range
    case params[:filter_date_range]
    when 'today'
      today_range
    when 'yesterday'
      yesterday_range
    when 'last_7_days'
      last_7_days_range
    when 'last_30_days'
      last_30_days_range
    when 'this_month'
      this_month_range
    when 'last_month'
      last_month_range
    when 'custom_range'
      custom_range
    else
      default_range
    end
  end

  def today_range
    Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
  end

  def yesterday_range
    1.day.ago.beginning_of_day..1.day.ago.end_of_day
  end

  def last_7_days_range
    7.days.ago.beginning_of_day..Time.zone.now.end_of_day
  end

  def last_30_days_range
    30.days.ago.beginning_of_day..Time.zone.now.end_of_day
  end

  def this_month_range
    Time.zone.now.beginning_of_month..Time.zone.now.end_of_month
  end

  def last_month_range
    1.month.ago.beginning_of_month..1.month.ago.end_of_month
  end

  def custom_range
    # your existing custom_range code
  end

  def default_range
    1.day.ago.beginning_of_day..1.day.ago.end_of_day
  end
end
