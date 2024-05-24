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


# Output detailed information of the first 100 cellphones
puts "First 100 Cellphones:"
cell.get_cellphones.first(10).each_with_index do |phone, index|
  puts "Cellphone ##{index + 1}:"
  phone.instance_variables.each do |var|
    puts "#{var.to_s.delete('@')}: #{phone.instance_variable_get(var)}"
  end
  puts "----------------------------"
end

# Function to calculate average weight for each OEM
def calculate_average_weight(cell)
  # Initialize a hash to store the total weight and count of devices for each OEM
  oem_weights = Hash.new { |hash, key| hash[key] = { total_weight: 0, count: 0 } }

  # Iterate over each cellphone
  cell.get_cellphones.each do |phone|
    # Get the OEM name and weight of the device
    oem = phone.get_oem
    weight = phone.get_body_weight.to_f  # Convert weight to a floating-point number

    # Add weight to the total weight for the OEM and increment the count
    oem_weights[oem][:total_weight] += weight
    oem_weights[oem][:count] += 1
  end

  # Initialize a hash to store the average weight for each OEM
  average_weights = {}

  # Calculate the average weight for each OEM
  oem_weights.each do |oem, data|
    total_weight = data[:total_weight]
    count = data[:count]

    # Calculate the average weight (handling division by zero)
    average_weight = count.zero? ? nil : total_weight / count.to_f

    # Store the average weight for the OEM
    average_weights[oem] = average_weight
  end

  # Return the hash of average weights
  average_weights
end

puts "Average Weight for Each OEM:"
average_weights = calculate_average_weight(cell)
average_weights.each do |oem, average_weight|
  puts "#{oem}: #{average_weight || 'No data'}"
end
