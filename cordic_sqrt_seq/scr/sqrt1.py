import math

x = 2**19 + 2**17
y = 2**19 - 2**17

shamt = [1, 2, 3, 4, 4, 5, 6, 7, 8]

for i in shamt:
  print x, y
  if y > 0:
    x, y = x - (y >> i), y - (x >> i)
  else:
    x, y = x + (y >> i), y + (x >> i)

print x, y
numer = [2**(i*2) for i in shamt]
denom = [i-1 for i in numer]
coeff = math.sqrt( 1.0
                 * reduce(lambda x, y: x*y, numer)
                 / reduce(lambda x, y: x*y, denom) )
print x * coeff * 2**-19
