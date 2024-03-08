require "./repl"
require "./parser"
require "./interpreter"
require "./state"

include IGOL

history_file = "#{Dir.current}/history.log"
#state = GameOfLife.new(Set{ {0,0}, {1,0}, {2,0}, {0,1} })
state = GameOfLife.new(Set{ {-1,1}, {1,1}, {0,0}, {1,0}, {0 ,-1} })

Repl.new(history: history_file) { |input|
  command = IGOL.parser.parse(input)
  case command
  when Command
    state, output = IGOL.interpret(state, command)
    puts output
  else
    puts "Syntax error: #{command}"
  end
  # puts igol_parser.parse(input)
}

