import re

with open("../input/input05.txt") as f:
    polymer = f.read().strip()

def reduce(s):
    pad = s + s[-1]
    r = ""
    i = 0
    while i < len(s):
        if abs(ord(pad[i]) - ord(pad[i+1])) == 32:
            i += 2
        else:
            r += s[i]
            i += 1
    return r

def remove(u, s):
    f = lambda c : c not in [u.lower(), u.upper()]
    return filter(f, s)
            
def part1(s):
    p = None
    r = s
    while r != p:
        p = r
        r = reduce(r)
       
    return len(r)

def part2(s):
    units = set(s.lower())
    return min([part1(remove(u, s)) for u in units])

print part1(polymer)
print part2(polymer)
