require_relative 'tile_factory'
# To add a new way to construct a board
#   - add case in self.create method
#   - add case name in self.options
#   - implement method in TileFactory
module BoardFactory

  def self.options
    %w(default custom random)
  end

  def self.create(type)
    case type
    when 'default'
      TileFactory.create('default')
    when 'custom'
      TileFactory.create('custom')
    when 'random'
      TileFactory.create('random')
    else
      raise NotImplementedError,
            "#{self} cannot respond to #{type}"
    end
  end

end