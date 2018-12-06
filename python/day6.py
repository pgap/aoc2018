
coords = []

with open("../input/input06.txt") as f:
    for line in f:
        x, y = map(int, line.split(','))
        coords.append((x,y))

def distances(cs):
    xs, ys = zip(*cs)
    dist = {}

    for i in range(min(xs), max(xs)):
        for j in range(min(ys), max(ys)):
            dist[(i, j)] = [abs(x - i) + abs(y - j) for x, y in cs]

    return dist

def finite((x, y), cs):
    neighbours = [False] * 4

    for xp, yp in cs:
        if (xp < x) and (yp < y):
            neighbours[0] = True
        if (xp < x) and (yp > y):
            neighbours[1] = True
        if (xp > x) and (yp < y):
            neighbours[2] = True
        if (xp > x) and (yp > y):
            neighbours[3] = True

    return all(neighbours)

def part1(cs):
    dist = distances(cs)
    area = [0] * len(cs)

    for ds in dist.values():
        d = min(ds)
        if ds.count(d) == 1:
            area[ds.index(d)] += 1

    return max([area[i]
                for i, c in enumerate(cs)
                if finite(c, cs)])

def part2(cs):
    dist = distances(cs)
    area = 0

    for ds in dist.values():
        if sum(ds) < 10000:
            area += 1

    return area

print part1(coords)
print part2(coords)
