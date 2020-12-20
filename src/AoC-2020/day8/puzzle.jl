

function exec_cmds(cmds::Array)
    accumulator = 0
    index = 1
    executed = Set{Integer}()

    while !(index ∈ executed) && index <= length(cmds) && index >= 1
        if "acc" == cmds[index].c
            push!(executed, index)
            accumulator += cmds[index].a
            index += 1
        elseif "jmp" == cmds[index].c
            push!(executed, index)
            index += cmds[index].a
        elseif "nop" == cmds[index].c
            index += 1
        end
    end
    return index >= length(cmds), accumulator
end



function fix_cmds(cmds::Array)
    for (i, (cmd, arg)) in enumerate(cmds)
        cmd == "acc" && continue
        cmd == "nop" && arg == 0 && continue

        cmd = (cmd=="jmp") ? "nop" : "jmp"
        new_cmd = (c=cmd, a=arg)
        new_code = [cmds[1:i-1]..., new_cmd, cmds[i+1:end]...]
        result_status, acumulated = exec_cmds(new_code)

        result_status && return acumulated
    end
end


function parseInput(data::String)
    cmd, arg = split(data) .|> String
    arg = parse(Int64, arg)
    return (c=cmd, a=arg)
end


function puzzle()
    data = readlines(stdin) .|> parseInput
    println(exec_cmds(data))
    println(fix_cmds(data))
end

puzzle()