class Dates
	def get_dates(start_date, end_date, input_time, dates_to_exclude)
		#Parse dates passed to call
		begin
			if start_date.is_a? Date
				start = start_date.new_offset
			else
				start = DateTime.parse(start_date.to_s).new_offset
			end
			if end_date.is_a? Date
				finish = end_date.new_offset
			else
				finish = DateTime.parse(end_date.to_s).new_offset
			end
			if input_time.is_a? Date
				input = input_time.new_offset
			else
				input = DateTime.parse(input_time.to_s).new_offset
			end
			#Create dates exluded array
			not_in = Array.new
			dates_to_exclude.each do |date|
				if date.is_a? Date
					not_in.push(date)
				else 
					not_in.push(DateTime.parse(date.to_s))
				end
			end
		rescue ArgumentError
			#Error gracefully if dates are incorrectly formatted
			return false
		end
		#Check for valid dates
		if DateTime.valid_date?(start.year,start.month,start.day) and DateTime.valid_date?(finish.year,finish.month,finish.day) and DateTime.valid_date?(input.year,input.month,input.day)
			weekday = input.wday
			#Iterate through date range
			dates_to_return = Array.new
			(start..finish).each do |date|
				#Return date if it is valid
				if date.wday == weekday and !not_in.include? date.new_offset
					dates_to_return.push(date.strftime("%d/%m/%Y"))
				end
			end
			#Error gracefully if dates are incorrectly formatted
			return dates_to_return
	    else
	    	return false
	    end
	end
end