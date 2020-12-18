equal(leq::Function, a, b) = leq(a, b) && leq(b, a)

import Base.:<=
function binarySearch(data::Array{T}, key::T; start::Integer=1, finish::Integer=-1, compare::Function=Base.:<= ) :: Union{Nothing, Integer} where {T}
    if finish === -1 finish = length(data) end
    
    pm = div(finish+start, 2)

    if equal(compare, data[pm], key)
        return pm

    elseif equal(compare, data[start], key)
        return start

    elseif start >= finish
        return nothing

    elseif compare(data[pm], key)
        return binarySearch(data, key; start=pm+1,  finish=finish, compare=compare)
    else
        return binarySearch(data, key; start=start, finish=pm-1, compare=compare)
    end
end


