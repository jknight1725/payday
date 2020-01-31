module Builder
  include Enumerable
  extend self

  def each
    yield default
    yield custom
    yield random
    yield from_file
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

  def build_for(obj)
    puts "Pick a Build type for #{obj}"
    options = Builder.to_a
    options.each_with_index { |opt, index | puts "#{index}\t#{opt}" }
    choice = -1
    until (0..options.size).cover? choice
      puts "Pick an option:\t"
      choice = gets.to_i
    end
    options[choice]
  end
end