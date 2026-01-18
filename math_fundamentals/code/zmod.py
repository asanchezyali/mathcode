class Zmod:
    """
    Representa un elemento de Z/nZ.
    Implementa los axiomas de cuerpo mediante sobrecarga de operadores.
    """
    def __init__(self, value: int, modulus: int):
        self.modulus = modulus
        self.value = value % modulus

    def __repr__(self):
        return f"{self.value} (mod {self.modulus})"

    def __eq__(self, other):
        return self.value == other.value and self.modulus == other.modulus

    # AS1-AS4: Operaciones de suma
    def __add__(self, other):
        return Zmod(self.value + other.value, self.modulus)

    def __neg__(self):
        return Zmod(-self.value, self.modulus)

    def __sub__(self, other):
        return self + (-other)

    # AM1-AM5: Operaciones de multiplicacion
    def __mul__(self, other):
        return Zmod(self.value * other.value, self.modulus)

    def inverse(self):
        """Calcula el inverso multiplicativo usando Euclides extendido."""
        def extended_gcd(a, b):
            if a == 0:
                return b, 0, 1
            gcd, x1, y1 = extended_gcd(b % a, a)
            return gcd, y1 - (b // a) * x1, x1

        gcd, x, _ = extended_gcd(self.value, self.modulus)
        if gcd != 1:
            raise ValueError(f"{self.value} no tiene inverso en Z/{self.modulus}Z")
        return Zmod(x, self.modulus)

    def __truediv__(self, other):
        return self * other.inverse()
