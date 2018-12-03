import re
squares = []
fabric = {}

with open("../input/input03.txt") as f:
    for line in f:
        m = re.match("#(\d+) @ (\d+),(\d+): (\d+)x(\d+)", line)
        if m:
            s = map(int, m.groups())
            squares.append(s)
        else:
            print "parse error:", line


for id_, x, y, w, h in squares:
    for i in range(x, x + w):
        for j in range(y, y + h):
            fabric[(i, j)] = fabric.get((i, j), 0) + 1

def part1():
    cnt = 0
    for v in fabric.values():
        if v > 1:
            cnt += 1
    return cnt

def part2():
    for id_, x, y, w, h in squares:
        if all([ fabric[(i, j)] == 1 for i in range(x, x + w)
                                     for j in range(y, y + h)]):
            return id_

print part1()
print part2()

