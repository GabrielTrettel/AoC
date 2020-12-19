

# byr (Birth Year) - four digits; at least 1920 and at most 2002.
byr(val) = 1920 <= parse(Int64, val) <= 2002

# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
iyr(val) = 2010 <= parse(Int64, val) <= 2020

# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
eyr(val) = 2020 <= parse(Int64, val) <= 2030

# hgt (Height) - a number followed by either cm or in:
#     - If cm, the number must be at least 150 and at most 193.
#     - If in, the number must be at least 59 and at most 76.
hgt(val) = if val[end-1:end]=="cm"
    150 <= parse(Int64, val[1:end-2]) <= 193
else
    59 <= parse(Int64, val[1:end-2]) <= 76
end

# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
hcl(val) = length(val) == 7 && (match(r"\#[0-9a-f]*", val).match == val)

# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
ecl(val) = val in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

# pid (Passport ID) - a nine-digit number, including leading zeroes.
pid(val) = length(val) == 9 && (match(r"[0-9]+", val).match == val)

# cid (Country ID) - ignored, missing or not.
cid(val) = true


const tokens = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
getToken(field) = (String(field[1:3]), String(field[5:end]))


function isValidPassport(values::String) ::Bool
    fields = split(values, [' ', '\n'])

    if length(fields) < 6
        return false
    end

    fields = fields .|> String .|> getToken |> Dict

    if tokens ⊆ keys(fields)
        try
            return all( Meta.parse("""$f("$v")""") |> eval for (f,v) in fields )
        catch
            return false
        end
    end

    return false
end

function puzzle()
    data = read(stdin, String)
    data = split(data, "\n\n") .|> String
    passports = [isValidPassport(psp) for psp in data]
    println(sum(passports))
end

puzzle()