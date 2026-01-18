from zmod import Zmod

# Trabajando en Z/7Z (un cuerpo, pues 7 es primo)
a = Zmod(3, 7)
b = Zmod(5, 7)

print(a + b)       # 1 (mod 7), pues 3 + 5 = 8 = 1 (mod 7)
print(a * b)       # 1 (mod 7), pues 3 * 5 = 15 = 1 (mod 7)
print(a.inverse()) # 5 (mod 7), pues 3 * 5 = 1 (mod 7)
print(b / a)       # 4 (mod 7), pues 5 * 5 = 25 = 4 (mod 7)
