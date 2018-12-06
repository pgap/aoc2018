import re

sleepCount = {}

with open("../input/input04.txt") as f:
    for line in sorted(f):
        m = re.search("Guard #(\d+)", line)
        if m:
            guard = int(m.group(1))

        elif "falls asleep" in line:
            begin = int(line[15:17])

        elif "wakes up" in line:
            end   = int(line[15:17])
            
            if guard not in sleepCount:
                sleepCount[guard] = [0] * 60

            for minute in range(begin, end):
                sleepCount[guard][minute] += 1

def part1():
    maxSleep = 0
    for g, counts in sleepCount.items():
        sleep = sum(counts)
        if sleep > maxSleep:
            guard = g
            minute = counts.index(max(counts))
            maxSleep = sleep

    return guard * minute

def part2():
    maxSleep = 0
    for g, counts in sleepCount.items():
        sleep = max(counts)
        if sleep > maxSleep:
            guard = g
            minute = counts.index(sleep)
            maxSleep = sleep

    return guard * minute

print part1()
print part2()

