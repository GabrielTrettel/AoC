every_positive_answers(group::String) = split(group, '\n') .|> Set |> intersect |> length

any_positive_answers(group::String) = replace(group, "\n"=>"") |> Set |> length

function puzzle()
    data = split(read(stdin, String), "\n\n") .|> String

    any_positive_answers.(data) |> sum |> println
    every_positive_answers.(data) |> sum |> println
end

puzzle()