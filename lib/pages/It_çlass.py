A = [10,4,6,8]

a = A[0]
b = A[0]

for i in range (len(A)):
    if A[i]>a:
        a=A[i]
    if A[i]<b:
        b=A[i]

print(a-b)








A = [12,13,4,6,8,9]
B = []

for i in range (len(A)):
    if A[i]%3==0:
        B.append(A[i])

print(B)









odd_number = []
even_number = []
all_number = []
while True:
    x = int(input(""))
    if x == 0:
        break
    if x%2==0:
        even_number.append(x)
    else:
        odd_number.append(x)
    all_number.append(x)
print(even_number, "Even numbers")
print(odd_number, "Odd numbers")
print(all_number, "all number")











odd_number = []
even_number = []
all_number = []
neg_number = []
while True:
    x = int(input(""))
    if x == 0:
        break
    if x%2==0:
        even_number.append(x)
    elif x< 0:
        neg_number.append(x)
    else:
        odd_number.append(x)
    
    all_number.append(x)

print(even_number, "Even numbers")
print(odd_number, "Odd numbers")
print(all_number, "all number")
print(neg_number, "Negative number")

 