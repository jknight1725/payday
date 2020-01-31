require 'json'
module FileManager
  extend self

  def command(action, obj, data=nil)
    case action
    when 'save'
      FileWriter.for(obj).write(data)
    when 'load'
      FileReader.for(obj).read
    when 'erase'
      FileDeleter.for(obj).erase(data)
    else
      raise NotImplementedError,
            "#{self} cannot respond to #{action}"
    end
  end

  module FileWriter
    extend self
    def for(obj)
      case obj
      when 'game'
        GameWriter
      when 'board'
        BoardWriter
      when 'deal deck'
        DealWriter
      else
        raise NotImplementedError,
              "#{self} cannot respond to #{obj}"
      end
    end

    class GameWriter
      def self.write(data)
        File.open("game_save_file.json", "w") do |f|
          f.write(JSON.pretty_generate(data))
        end
      end
    end

    class BoardWriter
      def self.write(data)
        File.open("board_save_file.json", "w") do |f|
          f.write(JSON.pretty_generate(data))
        end
      end
    end

    class DealWriter
      def self.write(data)
        File.open("deal_save_file.json", "w") do |f|
          f.write(JSON.pretty_generate(data))
        end
      end
    end

  end

  module FileReader
    extend self
    def for(obj)
      case obj
      when 'game'
        GameReader
      when 'board'
        BoardReader
      when 'deal deck'
        DealReader
      else
        raise NotImplementedError,
              "#{self} cannot respond to #{obj}"
      end
    end

    class GameReader
      def self.read
        file = File.read('game_save_file.json')
        data = JSON.parse(file, :symbolize_names => true)
        data
      end
    end


    class BoardReader
      def self.read
        file = File.read('board_save_file.json')
        data = JSON.parse(file, :symbolize_names => true)
        data
      end
    end

    class DealReader
      def self.read
        file = File.read('deal_save_file.json')
        data = JSON.parse(file, :symbolize_names => true)
        data
      end
    end

    class PlayerReader
      def self.read
        file = File.read('player_save_file.json')
        data = JSON.parse(file, :symbolize_names => true)
        data
      end
    end

  end

  module FileDeleter
    extend self
    def for(obj)
      case obj
      when 'game'
        GameDeleter
      when 'board'
        BoardDeleter
      when 'deal deck'
        DealDeleter
      else
        raise NotImplementedError,
              "#{self} cannot respond to #{obj}"
      end
    end

    class GameDeleter
      def self.erase(data)
        puts "file #{data} erased"
      end
    end

    class BoardDeleter
      def self.erase
        nil
      end
    end

    class DealDeleter
      def self.erase
        nil
      end
    end

  end
FileManager::FileReader::DealReader.read
end