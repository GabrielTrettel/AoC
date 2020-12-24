function differenceAdapters(adapters::Array{Int64})
    diff = [1,1,1]

    for (i, jolt) in enumerate(adapters[1:end-1])
        diff[ abs(jolt - adapters[i+1]) ] += 1
    end

    return diff
end


# how can we get all adapter combinations that result in adapters[end]+3 jolts?
# R: with dynamic programming!
function nOfComb(adapters::Array{Int64})
    table = Dict([0=>1])

    push!(adapters, adapters[end]+3)
    for adapter in adapters
        table[adapter] = get!(table, adapter-1, 0) + get!(table, adapter-2, 0) + get!(table, adapter-3, 0)
    end

    return table[adapters[end]]
end



function puzzle()
    parseInt = x -> parse(Int64, x)
    adapters = readlines(stdin) .|> parseInt
    sort!(adapters)

    @show one,two,three = differenceAdapters(adapters) 
    @show one * three

    @show nOfComb(adapters)
end

puzzle()
