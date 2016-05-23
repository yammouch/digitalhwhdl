import math

arr = []
arr.append([math.atanh(2**i) for i in range(-1, -5, -1)])
arr.append([math.atanh(2**i) for i in range(-4, -9, -1)])

print(2.0**-15)
print(math.atanh(2**-8))
print(math.cosh(math.atanh(2**-8))-1.0)
for i in range(len(arr)):
  print (sum(arr[i]), arr[i][0] - sum(arr[i][1:]))

#coeff = \
#   1.0 \
# / math.sqrt( reduce( lambda x, y: x*y
#                    , [ 1 + 2**(2*i) for i in
#                        range(-1, -5, -1) + range(-4, -9, -1)] ))
shamts = range(1, 5) + range(4, 9)
numer = [2**(i*2) for i in shamts]
demon = [n+1 for n in numer]
coeff = math.sqrt( 1.0
                 * reduce(lambda x, y: x*y, numer)
                 / reduce(lambda x, y: x*y, demon) )
print (coeff, coeff*2**19, "%X" % math.floor(coeff*2**19))
