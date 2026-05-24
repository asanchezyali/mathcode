/*
 * Cálculo de coeficientes de diferencias finitas mediante el sistema de Vandermonde.
 *
 * Entrada: orden de derivada k, punto de evaluación x0, plantilla z[n]
 * Salida:  coeficientes c[n] tales que c·u ≈ u^(k)(x0)
 *
 * Referencia: R.J. LeVeque, Finite Difference Methods for ODEs and PDEs, §1.5
 *
 * Compilar: gcc -O2 -Wall -o fd_coefficients fd_coefficients.c -lm
 */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static double factorial(int n) {
    double f = 1.0;
    for (int i = 2; i <= n; i++)
        f *= i;
    return f;
}

/*
 * fd_coefficients: calcula los coeficientes de diferencias finitas.
 *   k  : orden de la derivada
 *   x0 : punto de evaluación
 *   z  : plantilla de n puntos
 *   n  : número de puntos
 *   c  : (salida) vector de coeficientes, tamaño n
 */
void fd_coefficients(int k, double x0, const double *z, int n, double *c) {
    /* Construir la matriz de Vandermonde escalada (almacenada por filas) */
    double *A = (double *)malloc(n * n * sizeof(double));
    double *b = (double *)calloc(n, sizeof(double));
    b[k] = 1.0;

    for (int i = 0; i < n; i++) {
        double delta = z[i] - x0;
        double power = 1.0;
        for (int row = 0; row < n; row++) {
            A[row * n + i] = power / factorial(row);
            power *= delta;
        }
    }

    /* Eliminación gaussiana con pivoteo parcial */
    for (int col = 0; col < n; col++) {
        /* Buscar pivote */
        int pivot = col;
        for (int row = col + 1; row < n; row++) {
            if (fabs(A[row * n + col]) > fabs(A[pivot * n + col]))
                pivot = row;
        }
        /* Intercambiar filas */
        if (pivot != col) {
            for (int j = 0; j < n; j++) {
                double tmp = A[col * n + j];
                A[col * n + j] = A[pivot * n + j];
                A[pivot * n + j] = tmp;
            }
            double tmp = b[col];
            b[col] = b[pivot];
            b[pivot] = tmp;
        }
        /* Eliminación */
        for (int row = col + 1; row < n; row++) {
            double f = A[row * n + col] / A[col * n + col];
            for (int j = col; j < n; j++)
                A[row * n + j] -= f * A[col * n + j];
            b[row] -= f * b[col];
        }
    }

    /* Sustitución hacia atrás */
    for (int i = n - 1; i >= 0; i--) {
        double sum = b[i];
        for (int j = i + 1; j < n; j++)
            sum -= A[i * n + j] * c[j];
        c[i] = sum / A[i * n + i];
    }

    free(A);
    free(b);
}

int main(void) {
    printf("=================================================================\n");
    printf("Coeficientes de diferencias finitas (sistema de Vandermonde)\n");
    printf("=================================================================\n");

    double h = 1.0;
    double c[5];

    /* Ejemplo 1: diferencia progresiva */
    double z1[] = {0.0, h};
    fd_coefficients(1, 0.0, z1, 2, c);
    printf("\n1) Diferencia progresiva (k=1, n=2)\n");
    printf("   Coeficientes: [%g, %g]\n", c[0], c[1]);

    /* Ejemplo 2: diferencia centrada k=1 */
    double z2[] = {-h, 0.0, h};
    fd_coefficients(1, 0.0, z2, 3, c);
    printf("\n2) Diferencia centrada (k=1, n=3)\n");
    printf("   Coeficientes: [%g, %g, %g]\n", c[0], c[1], c[2]);

    /* Ejemplo 3: segunda derivada centrada */
    fd_coefficients(2, 0.0, z2, 3, c);
    printf("\n3) Segunda derivada centrada (k=2, n=3)\n");
    printf("   Coeficientes: [%g, %g, %g]\n", c[0], c[1], c[2]);

    /* Ejemplo 4: tercera derivada centrada */
    double z3[] = {-2 * h, -h, 0.0, h, 2 * h};
    fd_coefficients(3, 0.0, z3, 5, c);
    printf("\n4) Tercera derivada centrada (k=3, n=5)\n");
    printf("   Coeficientes: [%g, %g, %g, %g, %g]\n", c[0], c[1], c[2], c[3], c[4]);

    /* Ejemplo 5: cuarta derivada centrada */
    fd_coefficients(4, 0.0, z3, 5, c);
    printf("\n5) Cuarta derivada centrada (k=4, n=5)\n");
    printf("   Coeficientes: [%g, %g, %g, %g, %g]\n", c[0], c[1], c[2], c[3], c[4]);

    /* Verificación: u(x) = cos(x), u''(0) = -1 */
    printf("\n=================================================================\n");
    printf("Verificación: u(x) = cos(x), u''(0) = -1\n");
    printf("=================================================================\n");
    int Ns[] = {10, 100, 1000};
    for (int i = 0; i < 3; i++) {
        double hv = 1.0 / Ns[i];
        double zv[] = {-hv, 0.0, hv};
        double cv[3];
        fd_coefficients(2, 0.0, zv, 3, cv);
        double approx = cv[0] * cos(zv[0]) + cv[1] * cos(zv[1]) + cv[2] * cos(zv[2]);
        double error = fabs(approx - (-1.0));
        printf("   h = %.0e:  aprox = %.10f,  error = %.6e\n", hv, approx, error);
    }

    return 0;
}
