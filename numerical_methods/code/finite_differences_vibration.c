/*
 * Método de diferencias finitas para el problema vibratorio:
 *     u'' + ω²u = 0,  u(0) = u₀,  u'(0) = 0,  t ∈ (0, T]
 *
 * Solución exacta: u(t) = u₀ cos(ωt)
 *
 * Compilar: gcc -o finite_differences_vibration finite_differences_vibration.c -lm
 * Ejecutar: ./finite_differences_vibration
 */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>

double *finite_differences_vibration(double u0, double omega, double T, int N) {
    double dt = T / N;
    double *u = (double *)malloc((N + 1) * sizeof(double));
    if (!u) {
        fprintf(stderr, "Error: no se pudo asignar memoria\n");
        exit(EXIT_FAILURE);
    }

    u[0] = u0;
    u[1] = u0 - 0.5 * omega * omega * dt * dt * u0;

    for (int n = 1; n < N; n++) {
        u[n + 1] = 2.0 * u[n] - u[n - 1] - omega * omega * dt * dt * u[n];
    }

    return u;
}

int main(void) {
    double u0 = 1.0;
    double omega = 2.0 * M_PI;
    double T = 5.0;
    int N = 500;

    double *u = finite_differences_vibration(u0, omega, T, N);

    double dt = T / N;
    double max_error = 0.0;
    for (int n = 0; n <= N; n++) {
        double t_n = n * dt;
        double u_exact = u0 * cos(omega * t_n);
        double error = fabs(u[n] - u_exact);
        if (error > max_error) {
            max_error = error;
        }
    }

    printf("Parámetros: u0=%.1f, omega=%.4f, T=%.1f, N=%d\n", u0, omega, T, N);
    printf("Error máximo: %.6e\n", max_error);

    /* Imprimir algunos valores para verificación */
    printf("\n%10s %15s %15s %15s\n", "t", "numérica", "exacta", "error");
    printf("%s\n", "------------------------------------------------------------");
    for (int n = 0; n <= N; n += N / 10) {
        double t_n = n * dt;
        double u_exact = u0 * cos(omega * t_n);
        printf("%10.4f %15.8f %15.8f %15.2e\n", t_n, u[n], u_exact,
               fabs(u[n] - u_exact));
    }

    free(u);
    return 0;
}
