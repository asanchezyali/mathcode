/*
 * Reglas de derivación del sistema formal MIU (acertijo MU de Hofstadter).
 *
 * Alfabeto: M, I, U.  Axioma inicial: MI.
 *
 *     Regla 1:  xI    -> xIU     (si termina en I, añadir U)
 *     Regla 2:  Mx    -> Mxx     (si empieza por M, duplicar el resto)
 *     Regla 3:  xIIIy -> xUy     (sustituir III por U)
 *     Regla 4:  xUUy  -> xy      (eliminar UU)
 *
 * Compilar: gcc -O2 -Wall -o miu_rules miu_rules.c
 * Ejecutar: ./miu_rules
 */

#include <stdbool.h>
#include <stdio.h>
#include <string.h>

#define MAX_LEN 256
#define MAX_DERIVATIONS 64

/*
 * Aplica las cuatro reglas del sistema MIU a una cadena.
 *
 * Escribe en 'derivations' las cadenas obtenidas en un solo paso y
 * devuelve cuántas se generaron. Las duplicadas se descartan.
 */
int apply_rules(const char *string, char derivations[][MAX_LEN]) {
    size_t length = strlen(string);
    int count = 0;

    /* Regla 1: xI -> xIU */
    if (length > 0 && string[length - 1] == 'I') {
        snprintf(derivations[count++], MAX_LEN, "%sU", string);
    }

    /* Regla 2: Mx -> Mxx */
    if (length > 0 && string[0] == 'M') {
        const char *rest = string + 1;
        snprintf(derivations[count++], MAX_LEN, "M%s%s", rest, rest);
    }

    /* Regla 3: III -> U (en todas las posiciones posibles) */
    for (size_t i = 0; i + 3 <= length; i++) {
        if (strncmp(string + i, "III", 3) == 0) {
            char *target = derivations[count];
            memcpy(target, string, i);
            target[i] = 'U';
            strcpy(target + i + 1, string + i + 3);
            count++;
        }
    }

    /* Regla 4: eliminar UU (en todas las posiciones posibles) */
    for (size_t i = 0; i + 2 <= length; i++) {
        if (strncmp(string + i, "UU", 2) == 0) {
            char *target = derivations[count];
            memcpy(target, string, i);
            strcpy(target + i, string + i + 2);
            count++;
        }
    }

    /* Descartar duplicados conservando el orden de aparición */
    int unique = 0;
    for (int i = 0; i < count; i++) {
        bool seen = false;
        for (int j = 0; j < unique; j++) {
            if (strcmp(derivations[i], derivations[j]) == 0) {
                seen = true;
                break;
            }
        }
        if (seen) {
            continue;
        }
        if (i != unique) {
            strcpy(derivations[unique], derivations[i]);
        }
        unique++;
    }

    return unique;
}

/*
 * Decide si una cadena es alcanzable desde el axioma MI.
 *
 * El invariante del sistema es el número de letras I módulo 3: partiendo
 * de MI (una sola I) ese residuo nunca llega a ser cero. Por eso MU, que
 * no tiene ninguna I, es inalcanzable.
 */
bool is_derivable(const char *string) {
    /* La cadena debe empezar por M y usar solo el alfabeto del sistema */
    if (string[0] != 'M') {
        return false;
    }

    int count_i = 0;
    for (const char *p = string; *p != '\0'; p++) {
        if (*p != 'M' && *p != 'I' && *p != 'U') {
            return false;
        }
        if (*p == 'I') {
            count_i++;
        }
    }

    return count_i % 3 != 0;
}

int main(void) {
    const char *axiom = "MI";
    char derivations[MAX_DERIVATIONS][MAX_LEN];

    int count = apply_rules(axiom, derivations);
    printf("Axioma: %s\n", axiom);
    printf("Derivaciones en un paso:");
    for (int i = 0; i < count; i++) {
        printf(" %s", derivations[i]);
    }
    printf("\n");

    printf("\nComprobación del invariante (número de I módulo 3):\n");
    const char *candidates[] = {"MU", "MIU", "MIUIU", "MUII", "MIIII"};
    int total = (int)(sizeof(candidates) / sizeof(candidates[0]));
    for (int i = 0; i < total; i++) {
        printf("  %-8s -> %s\n", candidates[i],
               is_derivable(candidates[i]) ? "derivable" : "NO derivable");
    }

    return 0;
}
