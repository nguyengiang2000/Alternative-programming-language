# frozen_string_literal: true

class Cell
  attr_accessor :oem, :model, :launch_announced, :launch_status, :body_dimensions, :body_weight,
                :body_sim, :display_type, :display_size, :display_resolution, :features_sensors, :platform_os

  def initialize
    @oem = {}
    @model = {}
    @launch_announced = {}
    @launch_status = {}
    @body_dimensions = {}
    @body_weight = {}
    @body_sim = {}
    @display_type = {}
    @display_size = {}
    @display_resolution = {}
    @features_sensors = {}
    @platform_os = {}
    @cellphones = []

  end

  # Getter and setter for oem
  def set_oem(key, value)
    @oem[key] = value
  end

  def get_oem(key)
    @oem[key]
  end

  # Getter and setter for model
  def set_model(key, value)
    @model[key] = value
  end

  def get_model(key)
    @model[key]
  end

  # Getter and setter for launch_announced
  def set_launch_announced(key, value)
    @launch_announced[key] = value
  end

  def get_launch_announced(key)
    @launch_announced[key]
  end

  # Getter and setter for launch_status
  def set_launch_status(key, value)
    @launch_status[key] = value
  end

  def get_launch_status(key)
    @launch_status[key]
  end

  # Getter and setter for body_dimensions
  def set_body_dimensions(key, value)
    @body_dimensions[key] = value
  end

  def get_body_dimensions(key)
    @body_dimensions[key]
  end

  # Getter and setter for body_weight
  def set_body_weight(key, value)
    @body_weight[key] = value
  end

  def get_body_weight(key)
    @body_weight[key]
  end

  # Getter and setter for body_sim
  def set_body_sim(key, value)
    @body_sim[key] = value
  end

  def get_body_sim(key)
    @body_sim[key]
  end

  # Getter and setter for display_type
  def set_display_type(key, value)
    @display_type[key] = value
  end

  def get_display_type(key)
    @display_type[key]
  end

  # Getter and setter for display_size
  def set_display_size(key, value)
    @display_size[key] = value
  end

  def get_display_size(key)
    @display_size[key]
  end

  # Getter and setter for display_resolution
  def set_display_resolution(key, value)
    @display_resolution[key] = value
  end

  def get_display_resolution(key)
    @display_resolution[key]
  end

  # Getter and setter for features_sensors
  def set_features_sensors(key, value)
    @features_sensors[key] = value
  end

  def get_features_sensors(key)
    @features_sensors[key]
  end

  # Getter and setter for platform_os
  def set_platform_os(key, value)
    @platform_os[key] = value
  end

  def get_platform_os(key)
    @platform_os[key]
  end

  # Retrieve all Cellphone objects stored in the array
  def get_cellphones
    @cellphones
  end

  # Add cellphone in the list
  def add_cellphone(cellphone)
    @cellphones << cellphone
  end

  # Delete cellphone in the list
  def delete_cellphone(cellphone)
    @cellphones.delete(cellphone)
  end

  # count for how many OEM in the list
  def get_oem_size
    @oem.size
  end
end

# Function to list all cellphones
def list_all_cellphones(cell)
  # Get all cellphone objects
  cellphones = cell.get_cellphones

  # Iterate over each cellphone and print its details
  cellphones.each_with_index do |phone, index|
    puts "Cellphone ##{index + 1}:"
    phone.instance_variables.each do |var|
      puts "#{var.to_s.delete('@')}: #{phone.instance_variable_get(var)}"
    end
    puts "----------------------------"
  end
end

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

# Function to delete duplicated cellphone objects
def delete_duplicates(cell)
  # Get all cellphone objects
  cellphones = cell.get_cellphones

  # Create a hash to store unique identifiers of cellphones
  unique_cellphones = {}

  # Iterate over each cellphone
  cellphones.each do |phone|
    # Define a unique identifier for comparison
    identifier = "#{phone.get_oem}_#{phone.get_model}"

    # Check if the identifier already exists
    if unique_cellphones[identifier]
      # If the identifier already exists, delete the duplicate cellphone object
      cell.delete_cellphone(phone)
    else
      # If the identifier doesn't exist, mark it as seen
      unique_cellphones[identifier] = true
    end
  end
end

# Function to list cellphones by OEM name
def list_cellphones_by_oem(cell, oem_name)
  # Get all cellphone objects
  cellphones = cell.get_cellphones

  # Filter cellphones by the provided OEM name
  selected_cellphones = cellphones.select { |phone| phone.get_oem == oem_name }

  # If no cellphones found for the given OEM name, print a message
  if selected_cellphones.empty?
    puts "No cellphones found for #{oem_name}."
  else
    # Print the details of cellphones for the given OEM name
    puts "Cellphones for #{oem_name}:"
    selected_cellphones.each_with_index do |phone, index|
      puts "Cellphone ##{index + 1}:"
      phone.instance_variables.each do |var|
        puts "#{var.to_s.delete('@')}: #{phone.instance_variable_get(var)}"
      end
      puts "----------------------------"
    end
  end
end
# Function to delete cellphones by OEM name
def delete_cellphones_by_oem(cell, oem_name)
  # Get all cellphone objects
  cellphones = cell.get_cellphones

  # Filter cellphones by the provided OEM name
  selected_cellphones = cellphones.select { |phone| phone.get_oem == oem_name }

  # Iterate over selected cellphones and delete them
  selected_cellphones.each do |phone|
    cell.delete_cellphone(phone)
  end

  # Print a message indicating the deletion
  puts "Deleted all cellphones for #{oem_name}."
end


