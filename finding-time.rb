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
      valid_dates = (start_date..end_date).select do |date|
        same_weekday?(date, input_time) && not_excluded?(date)
      end

      formatted_dates = format_dates(valid_dates)

      puts formatted_dates
      formatted_dates
    else
      puts 'Dates are incorrectly formatted.'
      []
    end
  end

  private
  
  def same_weekday?(date1, date2)
  	date1.wday == date2.wday
  end

  def not_excluded?(date)
  	!dates_to_exclude.include?(date.new_offset)
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

  def format_dates(dates)
  	formatted_dates = []
  	dates.each do |date|
  		formatted_dates << date.strftime("%d/%m/%Y")
  	end
  	formatted_dates
  end
end