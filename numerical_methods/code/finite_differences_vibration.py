"""
Método de diferencias finitas para el problema vibratorio:
    u'' + ω²u = 0,  u(0) = u₀,  u'(0) = 0,  t ∈ (0, T]

Solución exacta: u(t) = u₀ cos(ωt)
"""

import numpy as np
import matplotlib.pyplot as plt


def finite_differences_vibration(u0, omega, T, N):
    dt = T / N
    u = np.zeros(N + 1)
    u[0] = u0
    u[1] = u0 - 0.5 * omega**2 * dt**2 * u0

    for n in range(1, N):
        u[n + 1] = 2 * u[n] - u[n - 1] - omega**2 * dt**2 * u[n]

    return u


def main():
    u0 = 1.0
    omega = 2 * np.pi
    T = 5.0
    N = 500

    u = finite_differences_vibration(u0, omega, T, N)

    t = np.linspace(0, T, N + 1)
    u_exact = u0 * np.cos(omega * t)

    error = np.max(np.abs(u - u_exact))
    print(f"Parámetros: u0={u0}, ω={omega:.4f}, T={T}, N={N}")
    print(f"Error máximo: {error:.6e}")

    plt.figure(figsize=(10, 5))
    plt.plot(t, u_exact, "k-", linewidth=1.5, label="Exacta: $u_0 \\cos(\\omega t)$")
    plt.plot(t, u, "r--", linewidth=1.2, label=f"Diferencias finitas (N={N})")
    plt.xlabel("t")
    plt.ylabel("u(t)")
    plt.title("Método de diferencias finitas — Problema vibratorio")
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.savefig("vibration_python.png", dpi=150)
    plt.show()


if __name__ == "__main__":
    main()
