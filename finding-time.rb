require 'date'

class Dates
  attr_reader :start_date, :end_date, :input_time, :dates_to_exclude

  def initialize(start_date, end_date, input_time, dates_to_exclude)
    @start_date = parse_date(start_date)
    @end_date = parse_date(end_date)
    @input_time = parse_date(input_time)
    @dates_to_exclude = parse_dates(dates_to_exclude)
  end

  def get_dates
    unless start_date.nil? || end_date.nil? || input_time.nil?
      weekday = input_time.wday
      dates_to_return = []
      (start_date..end_date).each do |date|
        if date.wday == weekday && !dates_to_exclude.include?(date.new_offset)
          dates_to_return << date.strftime("%d/%m/%Y")
        end
      end

      puts dates_to_return
      dates_to_return
    else
      puts 'Dates are incorrectly formatted.'
      []
    end
  end
  
  def parse_date(date)
    if date.is_a? Date
      date.new_offset
    else
      begin
	      DateTime.parse(date.to_s).new_offset
	    rescue
	      nil
	    end
    end
  end
  
  def parse_dates(dates)
    parsed_dates = []
    dates.each do |date|
      parsed_dates << parse_date(date)
    end
    parsed_dates
  end
end