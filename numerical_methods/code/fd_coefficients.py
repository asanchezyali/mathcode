"""
Cálculo de coeficientes de diferencias finitas mediante el sistema de Vandermonde.

Entrada: orden de derivada k, punto de evaluación x0, plantilla z
Salida:  coeficientes c tales que c·u ≈ u^(k)(x0)

Referencia: R.J. LeVeque, Finite Difference Methods for ODEs and PDEs, §1.5
"""

from math import factorial, cos, pi


def fd_coefficients(k, x0, z):
    n = len(z)
    if k >= n:
        raise ValueError("Se requieren al menos k+1 puntos en la plantilla")

    # Construir la matriz de Vandermonde escalada
    delta = [zj - x0 for zj in z]
    A = [[delta[j] ** i / factorial(i) for j in range(n)] for i in range(n)]
    b = [1.0 if i == k else 0.0 for i in range(n)]

    # Eliminación gaussiana con pivoteo parcial
    for col in range(n):
        pivot = max(range(col, n), key=lambda r: abs(A[r][col]))
        A[col], A[pivot] = A[pivot], A[col]
        b[col], b[pivot] = b[pivot], b[col]
        for row in range(col + 1, n):
            f = A[row][col] / A[col][col]
            for j in range(col, n):
                A[row][j] -= f * A[col][j]
            b[row] -= f * b[col]

    # Sustitución hacia atrás
    c = [0.0] * n
    for i in range(n - 1, -1, -1):
        c[i] = (b[i] - sum(A[i][j] * c[j] for j in range(i + 1, n))) / A[i][i]

    return c


def main():
    print("=" * 65)
    print("Coeficientes de diferencias finitas (sistema de Vandermonde)")
    print("=" * 65)

    # Ejemplo 1: diferencia progresiva, k=1, n=2
    h = 1.0
    z = [0.0, h]
    c = fd_coefficients(1, 0.0, z)
    print(f"\n1) Diferencia progresiva (k=1, n=2)")
    print(f"   Plantilla: {z}")
    print(f"   Coeficientes: {c}")

    # Ejemplo 2: diferencia centrada, k=1, n=3
    z = [-h, 0.0, h]
    c = fd_coefficients(1, 0.0, z)
    print(f"\n2) Diferencia centrada (k=1, n=3)")
    print(f"   Plantilla: {z}")
    print(f"   Coeficientes: {c}")

    # Ejemplo 3: segunda derivada centrada, k=2, n=3
    c = fd_coefficients(2, 0.0, z)
    print(f"\n3) Segunda derivada centrada (k=2, n=3)")
    print(f"   Plantilla: {z}")
    print(f"   Coeficientes: {c}")

    # Ejemplo 4: tercera derivada centrada, k=3, n=5
    z = [-2 * h, -h, 0.0, h, 2 * h]
    c = fd_coefficients(3, 0.0, z)
    print(f"\n4) Tercera derivada centrada (k=3, n=5)")
    print(f"   Plantilla: {z}")
    print(f"   Coeficientes: {c}")

    # Ejemplo 5: cuarta derivada centrada, k=4, n=5
    c = fd_coefficients(4, 0.0, z)
    print(f"\n5) Cuarta derivada centrada (k=4, n=5)")
    print(f"   Plantilla: {z}")
    print(f"   Coeficientes: {c}")

    # Verificación numérica con u(x) = cos(x), u''(0) = -1
    print(f"\n{'=' * 65}")
    print("Verificación: u(x) = cos(x), u''(0) = -1")
    print(f"{'=' * 65}")
    for N in [10, 100, 1000]:
        h = 1.0 / N
        z = [-h, 0.0, h]
        c = fd_coefficients(2, 0.0, z)
        approx = sum(cj * cos(zj) for cj, zj in zip(c, z))
        error = abs(approx - (-1.0))
        print(f"   h = {h:.0e}:  aprox = {approx:.10f},  error = {error:.6e}")


if __name__ == "__main__":
    main()
