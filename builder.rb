module Builder
  extend self
  def options
    %w(default custom random from_file)
  end

  def default
    'default'
  end

  def custom
    'custom'
  end

  def random
    'random'
  end

  def from_file
    'load'
  end

  def get_build_for(obj)
    puts "Pick a Build type for #{obj}"
    options = Builder.options
    options.each_with_index { |opt, index | puts "#{index}\t#{opt}" }

    choice = -1
    until (0..options.size).cover? choice
      puts "Pick an option:\t"
      choice = gets.to_i
    end
    options[choice]
  end
end