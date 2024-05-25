# frozen_string_literal: true

class Cellphone
  attr_accessor :oem, :model, :launch_announced, :launch_status, :body_dimensions,
                :body_weight, :body_sim, :display_type, :display_size, :display_resolution,
                :features_sensors, :platform_os

  def initialize(row)
    @oem = row['oem']
    @model = row['model']
    @launch_announced = row['launch_announced']
    @launch_status = row['launch_status']
    @body_dimensions = row['body_dimensions']
    @body_weight = row['body_weight']
    @body_sim = row['body_sim']
    @display_type = row['display_type']
    @display_size = row['display_size']
    @display_resolution = row['display_resolution']
    @features_sensors = row['features_sensors']
    @platform_os = row['platform_os']

    if row
      # Initialize with values from the row if provided
      @oem = row['oem']
      @model = row['model']
      @launch_announced = row['launch_announced']
      @launch_status = row['launch_status']
      @body_dimensions = row['body_dimensions']
      @body_weight = row['body_weight']
      @body_sim = row['body_sim']
      @display_type = row['display_type']
      @display_size = row['display_size']
      @display_resolution = row['display_resolution']
      @features_sensors = row['features_sensors']
      @platform_os = row['platform_os']
    end
  end

  # Setter methods
  def set_oem(value)
    @oem = value
  end

  def set_model(value)
    @model = value
  end

  def set_launch_announced(value)
    @launch_announced = value
  end

  def set_launch_status(value)
    @launch_status = value
  end

  def set_body_dimensions(value)
    @body_dimensions = value
  end

  def set_body_weight(value)
    @body_weight = value
  end

  def set_body_sim(value)
    @body_sim = value
  end

  def set_display_type(value)
    @display_type = value
  end

  def set_display_size(value)
    @display_size = value
  end

  def set_display_resolution(value)
    @display_resolution = value
  end

  def set_features_sensors(value)
    @features_sensors = value
  end

  def set_platform_os(value)
    @platform_os = value
  end

  # Getter methods
  def get_oem
    @oem
  end

  def get_model
    @model
  end

  def get_launch_announced
    @launch_announced
  end

  def get_launch_status
    @launch_status
  end

  def get_body_dimensions
    @body_dimensions
  end

  def get_body_weight
    @body_weight
  end

  def get_body_sim
    @body_sim
  end

  def get_display_type
    @display_type
  end

  def get_display_size
    @display_size
  end

  def get_display_resolution
    @display_resolution
  end

  def get_features_sensors
    @features_sensors
  end

  def get_platform_os
    @platform_os
  end
end

