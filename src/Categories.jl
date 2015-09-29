VERSION > v"0.4-" && __precompile__()

module Categories

using Lazy, Graphs

type Category{O}
  object::Set{O}
  morphism::Set{O->O}
  source = ((O->O)->O)
  target::Set{((O->O)->O)}
end

end
