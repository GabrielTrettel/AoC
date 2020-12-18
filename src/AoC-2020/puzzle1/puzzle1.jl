include("../../utils/searches.jl")


const parse_int = x -> parse(Int64, x)


function sum2020_2()
    yrs = readlines(stdin) .|> parse_int |> sort!

    for yr in yrs
        candidate = 2020 - yr
        candidate_idx = binarySearch(yrs, candidate)
        if candidate_idx !== nothing
            mult = yr * yrs[candidate_idx]
            sum = yr + yrs[candidate_idx]
            println("""Find a match!!
            $yr + $(yrs[candidate_idx]) = $sum
            $yr * $(yrs[candidate_idx]) = $mult""")
            break
        end
    end
end


function sum2020_3()
    yrs = readlines(stdin) .|> parse_int |> sort!
    min_y = first(yrs)
    max_y = last(yrs)

    for (i, yr_a) in enumerate(yrs)
        for (j, yr_b) in enumerate(yrs[i:end])
            if i == j || (yr_a + yr_b + max_y) < 2020 || (yr_a + yr_b + min_y) > 2020
                continue
            end

            candidate = 2020 - (yr_a + yr_b)
            candidate_idx = binarySearch(yrs, candidate)
        
            if candidate_idx !== nothing
                mult = yr_a * yr_b * yrs[candidate_idx]
                sum = yr_a * yr_b + yrs[candidate_idx]
                println("""Find a match!!
                $yr_a + $yr_b + $(yrs[candidate_idx]) = $sum
                $yr_a * $yr_b * $(yrs[candidate_idx]) = $mult""")                
                return
            end
        end
    end
end

sum2020_2()
# sum2020_3()