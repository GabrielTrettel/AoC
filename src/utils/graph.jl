

mutable struct AdjListGraph
    graph :: Dict{String, Set}

    function AdjListGraph()
        new(Dict{String, Set}())        
    end
end

import Base.push!
function push!(g::AdjListGraph, edge::Pair)
    if !haskey(g.graph, edge.first)
        g.graph[edge.first] = Set([edge.second])
    else
        push!(g.graph[edge.first], edge.second)
    end
end

function hasOutNode(g::AdjListGraph, node)
    return haskey(g.graph, node)
end

function outNodes(g::AdjListGraph, node)
    if hasOutNode(g, node)
        return g.graph[node]
    else
        return Set([])
    end
end


function hasEdge(g::AdjListGraph, edge::Pair)
     if haskey(g.graph, edge.first)
        return edge.second ∈ g.graph[edge.first]
     end
     return false
end


