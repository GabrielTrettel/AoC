sig(s) = s == 'F' || s == 'L' ? Base.:- : Base.:+

function seat(data::String)
    row = 127 + sum(sig(s)(2^(7-i)) for (i,s) in enumerate(data[1:7]))
    col = 7 + sum(sig(s)(2^(3-i)) for (i,s) in enumerate(data[8:end]))

    return div(row, 2)*8  + div(col, 2)
end


function puzzle()
    data = readlines(stdin)
    seats = [seat(code) for code in data]
    
    max_seat = max(seats...)
    println(max_seat)

    S = (length(seats)+1) * seats[1]
    println(S - sum(seats))
end

puzzle()