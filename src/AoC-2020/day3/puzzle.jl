const tree = '#'

function next_cords(cords::NamedTuple, map::Array, slope_offset) :: NamedTuple
    new_x = ((cords.x + (slope_offset.x-1)) % length(map[1])) +1 # 1-inxed array shit
    new_y = cords.y + slope_offset.y

    return (x=new_x, y=new_y)
end


function puzzle1(map::Array, slope_offset::NamedTuple = (x=3, y=1))
    toboggan_coordinate = (x=1, y=1)
    trees_hitted = 0
    
    while toboggan_coordinate.y <= length(map)
        if map[toboggan_coordinate.y][toboggan_coordinate.x] == tree
            trees_hitted += 1
        end
        toboggan_coordinate = next_cords(toboggan_coordinate, map, slope_offset)
    end

    return trees_hitted
end

"""
Complexity of O(n) for time and space
with n being the length of the map.

"""
function problem()
      data = readlines(stdin)
      println(puzzle1(data))

      slopes = [(x=1, y=1), (x=3, y=1), (x=5, y=1), (x=7, y=1), (x=1, y=2)]
      trees_hitted = [puzzle1(data, slope) for slope in slopes]
      println(trees_hitted, " ", foldr(*, trees_hitted))
end

problem()