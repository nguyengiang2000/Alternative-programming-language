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

  # Add cellphone in the list
  def add_cellphone(cellphone)
    @cellphones << cellphone
  end
  # Delete cellphone in the list
  def delete_cellphone(cellphone)
    @cellphones.delete(cellphone)
  end
  # Retrieve all Cellphone objects stored in the array
  def get_cellphones
    @cellphones
  end
  def get_oem_size
    @oem.size
  end
end