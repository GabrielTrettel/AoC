
const parseInt = x -> parse(Int64, x)

function parse_line(line)
    (xs, pswd) = split(line, ": ")
    (xs, letter) = split(xs, " ")
    (first_n, sec_n) = split(xs, "-") .|> parseInt

    return (first_n, sec_n, letter, pswd) 
end

function pswd_policy_1(line :: String)
    (at_least, at_most, letter, pswd) = parse_line(line)
    qtd = count(letter, pswd)

    return at_least <= qtd <= at_most
end

function pswd_policy_2(line :: String)
    (first_idx, sec_idx, letter, pswd) = parse_line(line)

    has_first = pswd[first_idx] == letter[1]
    has_sec = pswd[sec_idx] == letter[1]

    return has_first ⊻ has_sec
end

function check_pswd_validity()
    data = readlines(stdin)

    valid_pswds_1 = [line for line in data if pswd_policy_1(line)]
    valid_pswds_2 = [line for line in data if pswd_policy_2(line)]

    println(length(valid_pswds_1)," ", length(valid_pswds_2))
end

check_pswd_validity()