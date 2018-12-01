inp = []

with open("../input/input01.txt") as f:
    inp = [int(line) for line in f]

def part1(xs):
    return sum(xs)

def part2(xs):
    i = 0
    psum = 0
    seen = set()

    while True:
        psum += xs[i % len(xs)]
        i += 1        
        if psum in seen:
            return psum
        seen.add(psum)

print part1(inp)
print part2(inp)
