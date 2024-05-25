require 'csv'
require_relative 'Cell'
require_relative 'Cellphone'

# Define the path to your CSV file
csv_path = 'C:/Users/giang/RubymineProjects/Alternative-programming-language/scr/cells.csv'

# Initialize Cell object
cell = Cell.new

# Method to handle missing values, increment counts, and create Cellphone objects
def process_value(cell, key, value, row)
  value ||= "null" # Replace nil values with "null"
  value = "null" if value == "-" # Replace "-" with "null"

  # Cleaning data for launch_announced
  if key == 'launch_announced'
    # Convert string year to integer
    value = value[/\d{4}/].to_i if value =~ /\d{4}/
  end

  # Cleaning data for launch_status
  if key == 'launch_status' && value.include?(',')
    # Keep everything before the comma
    value = value.split(',')[0]
  end

  # Cleaning data for body_weight
  if key == 'body_weight'
    # Extract the number of grams using regex
    grams_match = value.match(/(\d+)\s*g/)
    if grams_match
      grams = grams_match[1].to_f # Extract the matched grams and convert to float
      value = grams
    else
      value = "null" # Replace invalid values with "null"
    end
  end

  # Cleaning data for body_sim
  if key == 'body_sim'
    # Replace "No" or "Yes" with "null"
    value = "null" if value.downcase == "no" || value.downcase == "yes"
  end

  # Cleaning data for display_size
  if key == 'display_size'
    # Extract the numerical value before "inches"
    size_match = value.match(/(\d+(\.\d+)?)\s*inches/i)
    if size_match
      size = size_match[1].to_f # Extract the matched value and convert to float
      value = size
    else
      value = "null" # Replace missing or invalid values with "null"
    end
  end

  # Cleaning data for features_sensors
  if key == 'features_sensors'
    # Replace invalid or missing values with "null", except "V1"
    value = "null" if !value.match?(/[a-zA-Z]/) || value.to_f.to_s == value
  end

  # Cleaning data for platform_os
  if key == 'platform_os'
    # Shorten the value to just the name
    value = value.split(',')[0]
  end

  cell.send("set_#{key}", value, cell.send("get_#{key}", value).to_i + 1)

  # initializing object phone and add them into cellphone list!
  if key == 'model'
    cellphone = Cellphone.new(row)
    cell.add_cellphone(cellphone)
  end
end


# Read the CSV file
CSV.foreach(csv_path, headers: true) do |row|
  # Iterate over each element in the row
  row.each do |key, value|
    # Process the value, increment counts, and create Cellphone objects
    process_value(cell, key, value, row)
  end
end

# Output the counts for each attribute
puts "OEM counts:"
puts cell.oem.inspect
puts "Model counts:"
puts cell.model.inspect
puts "Launch announced counts:"
puts cell.launch_announced.inspect
puts "Launch status counts:"
puts cell.launch_status.inspect
puts "Body dimensions counts:"
puts cell.body_dimensions.inspect
puts "Body weight counts:"
puts cell.body_weight.inspect
puts "Body SIM counts:"
puts cell.body_sim.inspect
puts "Display type counts:"
puts cell.display_type.inspect
puts "Display size counts:"
puts cell.display_size.inspect
puts "Display resolution counts:"
puts cell.display_resolution.inspect
puts "Features sensors counts:"
puts cell.features_sensors.inspect
puts "Platform OS counts:"
puts cell.platform_os.inspect


# Call the function to delete duplicated cellphone objects
delete_duplicates(cell)

# Function to calculate average weight for each OEM

puts "------------------------------------Average Weight for Each OEM: ------------------------------------"
average_weights = calculate_average_weight(cell)
average_weights.each do |oem, average_weight|
  puts "#{oem}: #{average_weight || 'No data'}"
end
puts "-----------------------------------------------------------------------------------------------------"

# Call the function to list cellphones by OEM name
#list_cellphones_by_oem(cell, "Huawei")  # Replace "Samsung" with the desired OEM name
# Delete phone by given OEM name
#delete_cellphones_by_oem(cell, "Xiaomi")
# Function to find phones announced in one year and released in another
#
