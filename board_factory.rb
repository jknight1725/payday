require_relative 'tile_arrangement'
require_relative 'builder'

module BoardFactory
  include Builder
  extend self

  def create(type)
    case type
    when default
      TileArrangement.for(default)
    when custom
      TileArrangement.for(custom)
    when random
      TileArrangement.for(random)
    else
      raise NotImplementedError,
            "#{self} cannot respond to #{type}"
    end
  end

end