/*
 * Verificación computacional de los axiomas de un plano proyectivo finito.
 *
 *     (P1) Dos puntos distintos determinan exactamente una recta.
 *     (P2) Dos rectas distintas se cortan en exactamente un punto.
 *     (P3) Existen cuatro puntos tales que ningún trío es colineal.
 *
 * Cada recta se representa como una máscara de bits: el bit i indica que el
 * punto i pertenece a la recta. Así la intersección de dos rectas es un AND
 * y contar sus puntos es contar bits a uno.
 *
 * Compilar: gcc -O2 -Wall -o finite_geometry finite_geometry.c
 * Ejecutar: ./finite_geometry
 */

#include <stdbool.h>
#include <stdio.h>
#include <string.h>

/* Cuenta cuántos bits a uno tiene la máscara */
static int popcount(unsigned int mask) {
    int count = 0;
    while (mask) {
        mask &= mask - 1;
        count++;
    }
    return count;
}

/* Comprueba si existen cuatro puntos sin ningún trío colineal */
static bool has_quadrangle(int num_points, const unsigned int *lines,
                           int num_lines) {
    for (int a = 0; a < num_points; a++) {
        for (int b = a + 1; b < num_points; b++) {
            for (int c = b + 1; c < num_points; c++) {
                for (int d = c + 1; d < num_points; d++) {
                    unsigned int quad = (1u << a) | (1u << b) | (1u << c) | (1u << d);
                    bool collinear = false;

                    /* Un trío es colineal si alguna recta contiene 3 de los 4 */
                    for (int i = 0; i < num_lines && !collinear; i++) {
                        if (popcount(quad & lines[i]) >= 3) {
                            collinear = true;
                        }
                    }

                    if (!collinear) {
                        return true;
                    }
                }
            }
        }
    }
    return false;
}

/*
 * Verifica si una estructura de incidencia satisface los axiomas de un
 * plano proyectivo. Escribe en 'message' la justificación del veredicto.
 */
bool is_projective_plane(int num_points, const unsigned int *lines,
                         int num_lines, char *message, size_t message_size) {
    /* (P1) Cada par de puntos está en exactamente una recta */
    for (int a = 0; a < num_points; a++) {
        for (int b = a + 1; b < num_points; b++) {
            unsigned int pair = (1u << a) | (1u << b);
            int incident = 0;

            for (int i = 0; i < num_lines; i++) {
                if ((lines[i] & pair) == pair) {
                    incident++;
                }
            }

            if (incident != 1) {
                snprintf(message, message_size,
                         "P1 falla: los puntos %d,%d están en %d rectas", a + 1,
                         b + 1, incident);
                return false;
            }
        }
    }

    /* (P2) Cada par de rectas se corta en exactamente un punto */
    for (int i = 0; i < num_lines; i++) {
        for (int j = i + 1; j < num_lines; j++) {
            int meet = popcount(lines[i] & lines[j]);
            if (meet != 1) {
                snprintf(message, message_size,
                         "P2 falla: las rectas %d,%d se cortan en %d puntos",
                         i + 1, j + 1, meet);
                return false;
            }
        }
    }

    /* (P3) Existen cuatro puntos en posición general */
    if (!has_quadrangle(num_points, lines, num_lines)) {
        snprintf(message, message_size,
                 "P3 falla: no existen cuatro puntos en posición general");
        return false;
    }

    snprintf(message, message_size, "La estructura es un plano proyectivo");
    return true;
}

/* Construye la máscara de bits de una recta a partir de sus puntos (base 1) */
static unsigned int make_line(int a, int b, int c) {
    unsigned int mask = (1u << (a - 1)) | (1u << (b - 1));
    if (c > 0) {
        mask |= 1u << (c - 1);
    }
    return mask;
}

int main(void) {
    char message[128];

    /* Plano de Fano, PG(2,2): 7 puntos y 7 rectas */
    unsigned int fano_lines[] = {
        make_line(1, 2, 3), make_line(1, 4, 5), make_line(1, 6, 7),
        make_line(2, 4, 6), make_line(2, 5, 7),
        make_line(3, 4, 7), make_line(3, 5, 6),
    };
    int fano_num_lines = (int)(sizeof(fano_lines) / sizeof(fano_lines[0]));

    bool valid = is_projective_plane(7, fano_lines, fano_num_lines, message,
                                     sizeof(message));
    printf("Plano de Fano: %s -> %s\n", message, valid ? "true" : "false");

    /* Geometría de tres puntos: cumple P1, pero no P3 */
    unsigned int triangle_lines[] = {
        make_line(1, 2, 0), make_line(1, 3, 0), make_line(2, 3, 0),
    };
    int triangle_num_lines =
        (int)(sizeof(triangle_lines) / sizeof(triangle_lines[0]));

    valid = is_projective_plane(3, triangle_lines, triangle_num_lines, message,
                                sizeof(message));
    printf("Geometría de tres puntos: %s -> %s\n", message,
           valid ? "true" : "false");

    return 0;
}
