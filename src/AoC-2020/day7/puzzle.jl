include("../../utils/graph.jl")

function filter_child_bag(bag::String)
    x = replace(bag, r"( bag[s.,]*)|(no other)"=>"")
    if x == ""
        return nothing
    end
    return (parse(Int64,x[1]), x[3:end])
end


function parse_input(data::String)
    parent_bag, xs = split(data, " bags contain ") .|> String
    children_bag = split(xs, ", ") .|> String .|> filter_child_bag
    
    if children_bag == [nothing]
        children_bag = []
    end

    return parent_bag, children_bag
end


function build_graph(data::Array)
    g_t = AdjListGraph()
    g = AdjListGraph()

    for (parent, children) in data
        for child in children
            # transposed Graph
            push!(g_t, last(child)=>parent)
            push!(g, parent=>child)
        end
    end
    return g_t, g
end


function path_length(g::AdjListGraph, nodes::Set)
    f = n->path_length(g, outNodes(g, n))
    children = map(f, collect(nodes))
    return foldr(∪, children, init=nodes)
end

function sub_bags(g::AdjListGraph, node::String)
    children = collect(outNodes(g, node))
    if children == []
        return 0
    end

    f = c -> first(c) + (first(c) * sub_bags(g, last(c)))
    return foldr(+, map(f, children))
end


function puzzle()
    data = readlines(stdin)
    vals = parse_input.(data) 
    transposed_graph, graph = build_graph(vals)
    
    s = path_length(transposed_graph, Set(["shiny gold"]))
    d = sub_bags(graph, "shiny gold")

    println(length(s))
    println(d)
end

puzzle()
