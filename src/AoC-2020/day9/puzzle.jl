
function firstNotPossibleSum(numbers::Array, preamble::Integer)
    for i in (preamble+1):length(numbers)
        target = numbers[i]
        
        slice = @views numbers[i-preamble:i-1]
        possible_numbers = Set(slice)
        can_sum = false
        for candidate_to_sum in slice
            adition_number = target - candidate_to_sum
            if (adition_number != candidate_to_sum) &&
               (adition_number ∈ possible_numbers)
                
                can_sum = true
                break
            end
        end
        !can_sum && return target
    end
    return nothing
end

function findRangeThatSums(numbers::Array, target::Integer)
    minimum_size = 2
    for start in 1:(length(numbers)-minimum_size)
        for finish in (start+minimum_size):length(numbers)
            slice = @views numbers[start:finish]
            sum(slice) == target && return slice
        end
    end
    return nothing
end


function puzzle()
    parseInt = x -> parse(Int64, x)
    numbers = readlines(stdin) .|> parseInt

    firstNotPossibleSum(numbers, 25) |> println
    range = findRangeThatSums(numbers, 556_543_474)
    println(min(range...)+max(range...))
end

puzzle()