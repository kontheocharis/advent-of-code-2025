import sys
import math


pos = 50
pwd = 0

for line in sys.stdin:
    orientation = -1 if line[0] == "L" else 1
    count = int(line[1:])

    k = pos + orientation * count
    if k <= 0:
        newzeros = (abs(k) // 100) + min(pos, 1)
    else:
        newzeros = k // 100

    pos = k % 100
    pwd += newzeros

print(pwd)
