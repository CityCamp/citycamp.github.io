require 'airrecord'
require 'json'

# 1. GET THE AIRTABLE DATA =====================================================
# Configure Airrecord with API Key
Airrecord.api_key = ENV['AIRTABLE_API_KEY']

# Define the Events Table
class Event < Airrecord::Table
  self.base_key = ENV['AIRTABLE_BASE_ID']
  self.table_name = ENV['AIRTABLE_TABLE_NAME']
end

# Fetch records from Airtable
events = Event.all.map(&:fields)
# Sort by State then City
events = events.sort_by { |h| [h["State"], h["City"]] }

# for each Event, set custom `slug`` & `description` attribute
events = events.map do |row|
  row["addressRegion"] = row["addressRegion"]&.first # pluck the first value for the CityCamp side.
  row["addressCountry"] = row["addressCountry"]&.first

  parts = [
    row["city"].gsub(" ", "-"),
    row["addressRegion"],
    row["addressCountry"]
  ]
  .compact # remove nil
  .reject(&:empty?)

  description_parts = [
    row["date"],
    row["city"],
    row["addressRegion"],
    row["addressCountry"]
  ]
  .compact # remove nil
  .reject(&:empty?)

  row["slug"] = parts.map { |part| part.to_s.gsub(".", "").gsub(",", "").gsub(" ", "-").downcase }.join('-')
  row["description"] = description_parts.join(', ')
  row
end

# order by `slug`
events = events.sort_by { |e| e["slug"] }

json_path = "_data/events.json"
new_data = JSON.pretty_generate(events)

# Read existing file if present
existing_data = File.exist?(json_path) ? File.read(json_path) : ""

# Check if data has changed
if new_data == existing_data
  puts "✅ No changes detected. Exiting..."
  exit 0
end

# 2. CREATE A BRANCH IF THERE ARE CHANGES ======================================
# Write new data to file
File.write(json_path, new_data)
puts "Saved #{events.size} events to #{json_path}"

# Generate branch name
date = Date.today.strftime("%Y-%m-%d")
branch_name = "update-events-#{date}"

# Set up Git
`git config --global user.email "github-actions@github.com"`
`git config --global user.name "GitHub Actions"`

# Create new branch
`git checkout -b #{branch_name}`

# Commit the new data file
`git add _data/events.json`
`git commit -m "Update events data from Airtable on #{date}"`

# Push the branch to remote
`git push origin #{branch_name}`

puts "Pushed changes to branch #{branch_name}"
