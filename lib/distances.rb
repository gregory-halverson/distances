require "distances/version"

module Math
  def self.sigdig(number)
    Math.log10(number).floor
  end
end

class Distance
  attr_reader :distance
  attr_accessor :mode, :readable

  @@ROUND = 13
  @@DECIMAL_PLACES = 2
  @@METERS_TO_FEET = 3.28084
  @@FEET_TO_METERS = 0.3048
  @@AU_TO_METERS = 149597870691.0

  def initialize(distance=0, mode=:metric, display=:readable)
    case mode
      when :metric
        self.from_meters distance
      when :imperial
        self.from_feet distance
      when :astronomical
        self.from_au distance
    end

    @mode = mode
    @display = display
  end

  def from_meters(meters)
    @distance = meters
    self
  end

  def from_feet(feet)
    from_meters(Distance.feet_to_meters(feet))
  end

  def from_au(au)
    from_meters(Distance.au_to_meters(au))
  end

  def self.meters_to_feet(meters)
    meters * @@METERS_TO_FEET
  end

  def self.feet_to_meters(feet)
    feet * @@FEET_TO_METERS
  end

  def self.meters_to_au(meters)
    meters / @@AU_TO_METERS
  end

  def self.au_to_meters(au)
    au * @@AU_TO_METERS
  end

  def meters
    self.distance
  end

  def decameters
    (self.meters / 10.0).round(@@ROUND)
  end

  def hectometers
    (self.meters / 100.0).round(@@ROUND)
  end

  def kilometers
    (self.meters / 1000.0).round(@@ROUND)
  end

  def megameters
    (self.meters / (10.0 ** 6)).round(@@ROUND)
  end

  def gigameters
    (self.meters / (10.0 ** 9)).round(@@ROUND)
  end

  def terameters
    (self.meters  / (10.0 ** 12)).round(@@ROUND)
  end

  def petameters
    (self.meters / (10.0 ** 15)).round(@@ROUND)
  end

  def exameters
    (self.meters / (10.0 ** 18)).round(@@ROUND)
  end

  def zettameters
    (self.meters / (10.0 ** 21)).round(@@ROUND)
  end

  def yottameters
    (self.meters / (10.0 ** 24)).round(@@ROUND)
  end

  def decimeters
    (self.meters * 10.0).round(@@ROUND)
  end

  def centimeters
    (self.meters * 100.0).round(@@ROUND)
  end

  def millimeters
    (self.meters * 1000.0).round(@@ROUND)
  end

  def micrometers
    (self.meters * (10.0 ** 6)).round(@@ROUND)
  end

  def nanometers
    (self.meters * (10.0 ** 9)).round(@@ROUND)
  end

  def picometers
    (self.meters * (10.0 ** 12)).round(@@ROUND)
  end

  def femtometers
    (self.meters * (10.0 ** 15)).round(@@ROUND)
  end

  def attometers
    (self.meters * (10.0 ** 18)).round(@@ROUND)
  end

  def zeptometers
    (self.meters * (10.0 ** 21)).round(@@ROUND)
  end

  def yoctometers
    (self.meters * (10.0 ** 24)).round(@@ROUND)
  end

  def feet
    self.meters * @@METERS_TO_FEET
  end

  def inches
    self.feet * 12
  end

  def thous
    self.inches * 1000
  end

  def yards
    self.feet / 3.0
  end

  def chains
    self.feet / 66.0
  end

  def furlongs
    self.feet / 660.0
  end

  def miles
    self.feet / 5280.0
  end

  def leagues
    self.feet / 15840.0
  end

  def fathoms
    self.feet / 6.0
  end

  def cables
    self.feet / 608.0
  end

  def nautical_miles
    self.feet / 6080.0
  end

  def au
    self.meters / @@AU_TO_METERS
  end

  def to_metric
    new_distance = self.clone
    new_distance.mode = :metric
    new_distance
  end

  def to_imperial
    new_distance = self.clone
    new_distance.mode = :imperial
    new_distance
  end

  def to_astronomical
    new_distance = self.clone
    new_distance.mode = :astronomical
    new_distance
  end

  def to_s_metric
    sigdig = Math.sigdig(self.meters)

    return "#{self.yottameters} Ym" if sigdig >= 24

    return "#{self.yoctometers} ym" if sigdig <= -24

    case sigdig
      when -23..-21
        return "#{self.zeptometers.round(@@DECIMAL_PLACES)} zm"
      when -20..-18
        return "#{self.attometers.round(@@DECIMAL_PLACES)} am"
      when -17..-15
        return "#{self.femtometers.round(@@DECIMAL_PLACES)} fm"
      when -14..-12
        return "#{self.picometers.round(@@DECIMAL_PLACES)} pm"
      when -11..-9
        return "#{self.nanometers.round(@@DECIMAL_PLACES)} nm"
      when -8..-6
        return "#{self.micrometers.round(@@DECIMAL_PLACES)} \u03bcm"
      when -5..-3
        return "#{self.millimeters.round(@@DECIMAL_PLACES)} mm"
      when -2
        return "#{self.centimeters.round(@@DECIMAL_PLACES)} cm"
      when -1
        return "#{self.decimeters.round(@@DECIMAL_PLACES)} dm"
      when 0
        return "#{self.meters.round(@@DECIMAL_PLACES)} m"
      when 1
        return "#{self.decameters.round(@@DECIMAL_PLACES)} dam"
      when 2
        return "#{self.hectometers.round(@@DECIMAL_PLACES)} hm"
      when 3..5
        return "#{self.kilometers.round(@@DECIMAL_PLACES)} km"
      when 6..8
        return "#{self.megameters.round(@@DECIMAL_PLACES)} Mm"
      when 9..11
        return "#{self.gigameters.round(@@DECIMAL_PLACES)} Gm"
      when 12..14
        return "#{self.terameters.round(@@DECIMAL_PLACES)} Tm"
      when 15..17
        return "#{self.petameters.round(@@DECIMAL_PLACES)} Pm"
      when 18..20
        return "#{self.exameters.round(@@DECIMAL_PLACES)} Em"
      when 21..23
        return "#{self.zettameters.round(@@DECIMAL_PLACES)} Zm"
      else
        return "#{self.meters.round(@@DECIMAL_PLACES)} m"
    end
  end

  def to_s_imperial
    feet = self.feet

    return "#{self.inches.round(@@DECIMAL_PLACES)} in" if feet < 1

    return "#{self.miles.round(@@DECIMAL_PLACES)} mi" if feet >= 5280 / 2

    "#{feet.round(@@DECIMAL_PLACES)} ft"
  end

  def to_s_astronomical
    "#{self.au} AU"
  end

  def to_f
    case mode
      when :metric
        self.meters.to_f
      when :imperial
        self.feet.to_f
      when :astronomical
        self.au.to_f
      else
        self.to_f.to_s
    end
  end

  def to_s
    case mode
      when :metric
        self.to_s_metric
      when :imperial
        self.to_s_imperial
      when :astronomical
        self.to_s_astronomical
      else
        self.to_f.to_s
    end
  end
end

def meters(meters)
  Distance.new meters, mode=:metric
end

def feet(feet)
  Distance.new feet, mode=:imperial
end

def inches(inches)
  Distance.new(inches / 12.0, mode=:imperial)
end

def miles(miles)
  Distance.new(miles * 5280, mode=:imperial)
end

def au(au)
  Distance.new au, mode=:astronomical
end