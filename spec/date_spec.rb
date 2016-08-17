require 'spec_helper'
require './finding-time'

RSpec.describe Dates do
	before(:all) do
		@array1 = ['07-09-2015', '15-09-2015', '16-09-2015']
		@array2 = ['07/09/2015', '15/09/2015', '16/09/2015']
		@array3 = ['09/15/2015', '09/16/2015', '09/17/2015']
		@array4 = ['07/09/2015', '14/09/2015', '21/09/2015', '28/09/2015']
		@array5 = [DateTime.parse('07/09/2015'), DateTime.parse('15/09/2015'), DateTime.parse('16/09/2015')]
		@array6 = [DateTime.parse('06/09/2015 22:00:00 -07:00'), DateTime.parse('14/09/2015 22:00:00 -07:00'), DateTime.parse('15/09/2015 22:00:00 -07:00')]
	end

	it "Checks for valid dates" do
		dates = Dates.new('09/13/2015', '09/30/2015', '09/18/2015', @array3).get_dates
		expect(dates).to eq([])
	end

	it "Returns an array" do
		dates = Dates.new('01-09-2015', '30-09-2015', '02-09-2015', @array1).get_dates
		expect(dates.is_a? Array).to be true
	end

	it "Returns an array containing dates between start_date and end_date that are on the same day of the week as input_time and do not appear in dates_to_exclude" do
		expected_dates = [DateTime.parse('02/09/2015').strftime("%d/%m/%Y"), DateTime.parse('09/09/2015').strftime("%d/%m/%Y"), DateTime.parse('23/09/2015').strftime("%d/%m/%Y"), DateTime.parse('30/09/2015').strftime("%d/%m/%Y")]
		dates = Dates.new('01-09-2015', '30-09-2015', '02-09-2015', @array1).get_dates
		expect(dates.length).to eq 4
		expect(dates).to eq expected_dates

		expected_dates = [DateTime.parse('14/09/2015').strftime("%d/%m/%Y"), DateTime.parse('21/09/2015').strftime("%d/%m/%Y"), DateTime.parse('28/09/2015').strftime("%d/%m/%Y")]
		dates = Dates.new('01-09-2015', '30-09-2015', '07-09-2015', @array1).get_dates
		expect(dates.length).to eq 3
		expect(dates).to eq expected_dates

		dates = Dates.new('01-09-2015', '30-09-2015', '07-09-2015', @array4).get_dates
		expect(dates.length).to eq 0

		expected_dates = [DateTime.parse('06/09/2015').strftime("%d/%m/%Y"), DateTime.parse('13/09/2015').strftime("%d/%m/%Y"), DateTime.parse('20/09/2015').strftime("%d/%m/%Y"), DateTime.parse('27/09/2015').strftime("%d/%m/%Y")]
		dates = Dates.new('01-09-2015', '30-09-2015', '06-09-2015', @array1).get_dates
		expect(dates.length).to eq 4
		expect(dates).to eq expected_dates

		expected_dates = [DateTime.parse('02/09/2015').strftime("%d/%m/%Y"), DateTime.parse('09/09/2015').strftime("%d/%m/%Y"), DateTime.parse('23/09/2015').strftime("%d/%m/%Y"), DateTime.parse('30/09/2015').strftime("%d/%m/%Y")]
		dates = Dates.new(DateTime.parse('31/08/2015 22:00:00 -07:00'), DateTime.parse('29/09/2015 22:00:00 -07:00'), DateTime.parse('01/09/2015 22:00:00 -07:00'), @array6).get_dates
		expect(dates.length).to eq 4
		expect(dates).to eq expected_dates
	end
end