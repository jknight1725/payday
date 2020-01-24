require_relative 'tile_factory'
# To add a new way to construct a board
#   - add case in self.for method
#   - add case name in self.options
#   - implement method in TileFactory
module BoardFactory

  def self.options
    %w(default custom random)
  end

  def self.for(type)
    case type
    when 'default'
      TileFactory.default_tiles
    when 'custom'
      TileFactory.custom_tiles
    when 'random'
      TileFactory.random_tiles
    else
      raise NotImplementedError,
            "#{self} cannot respond to #{type}"
    end
  end

end