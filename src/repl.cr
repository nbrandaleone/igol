require "fancyline"

class Repl
  def initialize(history : String, &process : String -> _)
    fancy = Fancyline.new
    if File.exists? history
      puts "Reading history from #{history}"
      File.open(history, "r") do |io|
        fancy.history.load io
      end
    end

    while input = fancy.readline("$$ ") # Ask the user for input
      begin
        process.call input
      rescue ex : Exception
        puts "error: #{ex}"
      end
    end
  rescue ex : Fancyline::Interrupt
    puts "Shutting down..."
  ensure
    File.open(history, "w") do |io|
      fancy.not_nil!.history.save io
    end
  end
end

#Repl.new(history: "#{Dir.current}/.history.log") { |input|
#  puts input
#  # raise Exception.new("noooo")
#}

