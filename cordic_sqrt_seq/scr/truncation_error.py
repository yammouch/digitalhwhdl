import math

arr = []
arr.append([math.atanh(2**i) for i in range(-1,  -5, -1)])
arr.append([math.atanh(2**i) for i in range(-4,  -9, -1)])

print(2.0**-15)
print(math.atanh(2**-8))
print(math.cosh(math.atanh(2**-8))-1.0)
for i in range(len(arr)):
  print (sum(arr[i]), arr[i][0] - sum(arr[i][1:]))