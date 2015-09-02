require 'spec_helper'
require './finding-time'

RSpec.describe Dates do
	#Set the dates_to_exclude arrays to be used for all tests
	before(:all) do
		#Dash formatting
		@array1 = ['07-09-2015', '15-09-2015', '16-09-2015']
		#Slash formatting
		@array2 = ['07/09/2015', '15/09/2015', '16/09/2015']
		@array3 = ['09/15/2015', '09/16/2015', '09/17/2015']
		@array4 = ['07/09/2015', '14/09/2015', '21/09/2015', '28/09/2015']
		#DateTime format
		@array5 = [DateTime.parse('07/09/2015'), DateTime.parse('15/09/2015'), DateTime.parse('16/09/2015')]
		#Mixed formatting
		@array6 = [DateTime.parse('06/09/2015 22:00:00 -07:00'), DateTime.parse('14/09/2015 22:00:00 -07:00'), DateTime.parse('15/09/2015 22:00:00 -07:00')]
	end

	it "Checks for valid dates" do
		#Invalid dates check
		dates = Dates.new.get_dates('09/13/2015', '09/30/2015', '09/18/2015', @array3)
		expect(dates).to be false
		#Valid dates checks
		dates = Dates.new.get_dates('01-09-2015', '30-09-2015', '02-09-2015', @array1)
		expect(dates).not_to be false
		dates = Dates.new.get_dates('01/09/2015', '30/09/2015', '02/09/2015', @array2)
		expect(dates).not_to be false
		dates = Dates.new.get_dates(DateTime.parse('01/09/2015'), DateTime.parse('30/09/2015'), DateTime.parse('02/09/2015'), @array5)
		expect(dates).not_to be false
		dates = Dates.new.get_dates(DateTime.parse('31/08/2015 22:00:00 -07:00'), DateTime.parse('29/09/2015 22:00:00 -07:00'), DateTime.parse('01/09/2015 22:00:00 -70:00'), @array6)
		expect(dates).not_to be false
	end

	it "Returns an array" do
		#Check that an array is returned
		dates = Dates.new.get_dates('01-09-2015', '30-09-2015', '02-09-2015', @array1)
		expect(dates.is_a? Array).to be true
	end

	it "Returns an array containing dates between start_date and end_date that are on the same day of the week as input_time and do not appear in dates_to_exclude" do
		#Check dash configuration
		dates = Dates.new.get_dates('01-09-2015', '30-09-2015', '02-09-2015', @array1)
		expect(dates.length).to eq 4
		expect(dates[0]).to eq DateTime.parse('02/09/2015').strftime("%d/%m/%Y")
		expect(dates[1]).to eq DateTime.parse('09/09/2015').strftime("%d/%m/%Y")
		expect(dates[2]).to eq DateTime.parse('23/09/2015').strftime("%d/%m/%Y")
		expect(dates[3]).to eq DateTime.parse('30/09/2015').strftime("%d/%m/%Y")

		#Check dash configuration with different dates
		dates = Dates.new.get_dates('01-09-2015', '30-09-2015', '07-09-2015', @array1)
		expect(dates.length).to eq 3
		expect(dates[0]).to eq DateTime.parse('14/09/2015').strftime("%d/%m/%Y")
		expect(dates[1]).to eq DateTime.parse('21/09/2015').strftime("%d/%m/%Y")
		expect(dates[2]).to eq DateTime.parse('28/09/2015').strftime("%d/%m/%Y")

		#Check that no dates are returned
		dates = Dates.new.get_dates('01-09-2015', '30-09-2015', '07-09-2015', @array4)
		expect(dates.length).to eq 0

		#Check dash configuration with different dates
		dates = Dates.new.get_dates('01-09-2015', '30-09-2015', '06-09-2015', @array1)
		expect(dates.length).to eq 4
		expect(dates[0]).to eq DateTime.parse('06/09/2015').strftime("%d/%m/%Y")
		expect(dates[1]).to eq DateTime.parse('13/09/2015').strftime("%d/%m/%Y")
		expect(dates[2]).to eq DateTime.parse('20/09/2015').strftime("%d/%m/%Y")
		expect(dates[3]).to eq DateTime.parse('27/09/2015').strftime("%d/%m/%Y")

		#Check with UK timezone
		dates = Dates.new.get_dates(DateTime.parse('31/08/2015 22:00:00 -07:00'), DateTime.parse('29/09/2015 22:00:00 -07:00'), DateTime.parse('01/09/2015 22:00:00 -07:00'), @array6)
		expect(dates.length).to eq 4
		expect(dates[0]).to eq DateTime.parse('02/09/2015').strftime("%d/%m/%Y")
		expect(dates[1]).to eq DateTime.parse('09/09/2015').strftime("%d/%m/%Y")
		expect(dates[2]).to eq DateTime.parse('23/09/2015').strftime("%d/%m/%Y")
		expect(dates[3]).to eq DateTime.parse('30/09/2015').strftime("%d/%m/%Y")
	end
end