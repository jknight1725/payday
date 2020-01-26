require_relative 'tile_setter'
require_relative 'builder'

module BoardFactory
  include Builder
  include TileSetter
  extend self

  def create(type)
    case type
    when default
      TileSetter.default_tiles
    when custom
      TileSetter.custom_tiles
    when random
      TileSetter.random_tiles
    else
      raise NotImplementedError,
            "#{self} cannot respond to #{type}"
    end
  end

end