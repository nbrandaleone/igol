require "./state"
require "./commands"

module IGOL
  #def self.interpret(state : State, command : Command) : {State, String}
  def self.interpret(state : GameOfLife, command : Command) : {GameOfLife, String}
    case command
    when Show
      #{state, state.grid.draw}
      {state, state.draw}
    when Evolve
      #new_grid = state.grid.evolve(command.n)
      #new_grid = state.evolve(command.n)
      #new_state = state.copy(grid: new_grid)
      new_state = state.evolve(command.n)
      {new_state, new_state.draw}
    when Apply
      coord = command.coord
      case pattern = command.pattern
      #case pattern = pattern.apply(coord)
#      pattern = case pattern_or_var = command.pattern
#                when Pattern
#                  pattern_or_var
#                when VarName
#                  var_name = pattern_or_var.name
#                  if ptr = state.variables[var_name]?
#                      ptr
#                  else
#                    raise Exception.new("Undefined variable: #{var_name}")
#                  end
#                else
#                  raise Exception.new("Unknown command")
#                end
      when Pattern
        live, dead = pattern.apply(coord)
        #new_grid = state.grid.add(live).remove(dead)
        #new_state = state.copy(grid: new_grid)
        new_state = state.add(live).remove(dead)
        {new_state, new_state.draw}
      when VarName
        raise Exception.new("Unsupported command")
      else
        raise Exception.new("Unknown command")
      end
    when SetVar
      raise Exception.new("unsupported setvar")
#      var_name = command.name.name
#      pattern = command.pattern
#      new_variables = state.variables.merge({ var_name => pattern })
#      new_state = state.copy(variables: new_variables)
#      {new_state, "#{var_name} set to #{pattern.pattern}"}
    else
      raise Exception.new("Unknown command")
    end
  end
end

# include IGOL
# state = GameOfLife.new(Set{ {0,0}, {1,0}, {2,0}, {0,1}})
# new_state, output = IGOL.interpret(state, Show.new)
# puts output
