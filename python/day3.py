import re

claims = []
fabric = {}

with open("../input/input03.txt") as f:
    for line in f:
        m = re.match("#(\d+) @ (\d+),(\d+): (\d+)x(\d+)", line)
        if m:
            rect = map(int, m.groups())
            claims.append(rect)
        else:
            print "parse error:", line


for id_, x, y, w, h in claims:
    for i in range(x, x + w):
        for j in range(y, y + h):
            fabric[(i, j)] = fabric.get((i, j), 0) + 1

def part1():
    cnt = 0
    for n in fabric.values():
        if n > 1:
            cnt += 1
    return cnt

def part2():
    for id_, x, y, w, h in claims:
        if all([ fabric[(i, j)] == 1 for i in range(x, x + w)
                                     for j in range(y, y + h)]):
            return id_

print part1()
print part2()

