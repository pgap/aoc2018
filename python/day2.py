
inp = []

with open("../input/input02.txt") as f:
    inp = [line.strip() for line in f]

def tally(s):
    counts = {}
    for c in s:
        counts[c] = counts.get(c, 0) + 1
    return counts

def commonChars(s1, s2):
    chars = [c1 for (c1, c2) in zip(s1, s2) if c1 == c2]
    return "".join(chars)

def part1(ids):
    count2 = 0
    count3 = 0

    for id_ in ids:
        counts = tally(id_)
        if any([n == 2 for n in counts.values()]):
            count2 += 1
        if any([n == 3 for n in counts.values()]):
            count3 += 1

    return count2 * count3
        
def part2(ids):
    for id1 in ids:
        for id2 in ids:
            common = commonChars(id1, id2) 
            if len(common) == len(id1) - 1:
                return common

print part1(inp)
print part2(inp)
            
