# puts 'Event Manager Initialized!'
# contents = File.read("event_attendees.csv")
# puts contents

# puts 'EventManager initialized.'

# lines = File.readlines('event_attendees.csv')
# lines.each do |line|
#   puts line
# end


#Display the first names of all attendees
# puts 'EventManager initialized.'
# lines = File.readlines("event_attendees.csv")
# lines.each do |line|
#    columns = line.split(",")
#    name = columns[2]
#   puts name
# end

#Skipping the header row
# puts 'EventManager initialized.'
# lines = File.readlines("event_attendees.csv")
# lines.each do |line|
#     next if line == " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode\n"
#     columns = line.split(",")
#   name = columns[2]
#   puts name
# end

# lines = File.readlines('event_attendees.csv')
# lines.each_with_index do |line,index|
#   next if index == 0
#   columns = line.split(",")
#   name = columns[2]
#   puts name
# end

#Switching over to use the CSV library
# require "csv"
# puts "event initialized"
# contents = CSV.open("event_attendees.csv", headers: true)
# contents.each do |row|
#   name = row[2]
#   puts name
# end

#Accessing columns by their names

# require "csv"
# contents = CSV.read(
#   "event_attendees.csv",
#   headers: true,
#   header_converters: :symbol
# )

# contents.each do |row|
#   name = row[:first_Name]
#   zipcode = row[:zipcode]
#   puts "#{name} #{zipcode}"
# end

# Iteration 2: Cleaning up our zip codes


# require 'csv'
# puts 'EventManager initialized.'
# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# contents.each do |row|
#   name = row[:first_Name]
#   zipcode = row[:zipcode]

#   if zipcode.nil?
#     zipcode = '00000'
#   elsif zipcode.length < 5
#     zipcode = zipcode.rjust(5,"0")[0..4]
#   elsif zipcode.length > 5
#     zipcode = zipcode[0..4]
#   end

#   puts "#{name} #{zipcode}"
# end

#Iteration 3: Using Google’s Civic Information

# require 'csv'
# require 'google/apis/civicinfo_v2'


# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5, '0')[0..4]
# end

# def legislators_by_zipcode(zip)
#   civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#   civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

#   begin
#     legislators = civic_info.representative_info_by_address(
#       address: zip,
#       levels: 'country',
#       roles: ['legislatorUpperBody', 'legislatorLowerBody']
#     )
#     legislators = legislators.officials
#     legislator_names = legislators.map(&:name)
#     legislator_names.join(", ")
#   rescue
#     'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
#   end
# end

# puts 'EventManager initialized.'

# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# contents.each do |row|
#   name = row[:first_name]

#   zipcode = clean_zipcode(row[:zipcode])

#   legislators = legislators_by_zipcode(zipcode)

#   puts "#{name} #{zipcode} #{legislators}"
# end

#Iteration 4: Form letters
# require 'csv'
# require 'google/apis/civicinfo_v2'
# require 'erb'

# def clean_zipcode(zipcode)
#   zipcode.to_s.rjust(5,"0")[0..4]
# end

# def legislators_by_zipcode(zip)
#   civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
#   civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

#   begin
#     civic_info.representative_info_by_address(
#       address: zip,
#       levels: 'country',
#       roles: ['legislatorUpperBody', 'legislatorLowerBody']
#     ).officials
#   rescue
#     'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
#   end
# end

# def save_thank_you_letter(id,form_letter)
#   Dir.mkdir('output') unless Dir.exist?('output')

#   filename = "output/thanks_#{id}.html"

#   File.open(filename, 'w') do |file|
#     file.puts form_letter
#   end
# end

# puts 'EventManager initialized.'

# contents = CSV.open(
#   'event_attendees.csv',
#   headers: true,
#   header_converters: :symbol
# )

# template_letter = File.read('form_letter.erb')
# erb_template = ERB.new template_letter

# contents.each do |row|
#   id = row[0]
#   name = row[:first_name]
#   zipcode = clean_zipcode(row[:zipcode])
#   legislators = legislators_by_zipcode(zipcode)

#   form_letter = erb_template.result(binding)

#   save_thank_you_letter(id,form_letter)
# end