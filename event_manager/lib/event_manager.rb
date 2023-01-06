require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(phone_number)
  phone_number = phone_number.gsub(/\W/, '')

  if phone_number.length < 10 || phone_number.length > 11
    '- Invalid phone number -'
  elsif phone_number.length == 11
    phone_number[0] == '1' ? phone_number[1..10] : '- Invalid phone number -'
  else
    phone_number
  end
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def count_hours(hours)
  hours_count = {}

  hours.each do |hour|
    hours_count[hour] = hours_count[hour].nil? ? 1 : hours_count[hour] + 1
  end

  hours_count
end

def count_weekdays(wdays)
  wdays.map! do |day|
    Date::DAYNAMES[day]
  end

  wdays_count = {}

  wdays.each do |day|
    wdays_count[day] = wdays_count[day].nil? ? 1 : wdays_count[day] + 1
  end

  wdays_count
end

def save_regist_report(form_report)
  filename = 'output/hours_report.html'

  File.open(filename, 'w') do |file|
    file.puts form_report
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)
erb_report = ERB.new(File.read('regist_report.erb'))
template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

hours = []
wdays = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)
  hour = row[:regdate].split(' ')[1].split(':')[0]
  date = row[:regdate].split(' ')[0].split('/')
  date_formated = Date.parse("20#{date[2]}/#{date[0]}/#{date[1]}").wday

  hours.push(hour)

  wdays.push(date_formated)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)
end

hours_count = count_hours(hours)
wdays_count = count_weekdays(wdays)
form_report = erb_report.result(binding)
save_regist_report(form_report)
