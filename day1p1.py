import sys


pos = 50
pwd = 0

for line in sys.stdin:
    orientation = -1 if line[0] == "L" else 1
    count = int(line[1:])

    pos += orientation * count
    pos = pos % 100
    if pos == 0:
        pwd += 1

print(pwd)
