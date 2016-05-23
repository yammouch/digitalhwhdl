x = 2**19 + 2**18
y = 2**19 - 2**18

for i in (1, 2, 3, 4, 4, 5, 6, 7, 8):
  print x, y
  if y > 0:
    x, y = x - (y >> i), y - (x >> i)
  else:
    x, y = x + (y >> i), y + (x >> i)
