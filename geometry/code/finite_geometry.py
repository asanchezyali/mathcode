"""
Verificación computacional de los axiomas de un plano proyectivo finito.

    (P1) Dos puntos distintos determinan exactamente una recta.
    (P2) Dos rectas distintas se cortan en exactamente un punto.
    (P3) Existen cuatro puntos tales que ningún trío es colineal.

El ejemplo canónico es el plano de Fano, PG(2,2): el plano proyectivo más
pequeño, con siete puntos y siete rectas.

Ejecutar: python3 finite_geometry.py
"""

from itertools import combinations


def is_projective_plane(points, lines):
    """
    Verifica si una estructura de incidencia satisface los axiomas de un
    plano proyectivo.

    Args:
        points: Colección de puntos.
        lines: Colección de rectas; cada recta es un conjunto de puntos.

    Returns:
        Par (is_valid, message) con el veredicto y su justificación.
    """
    points = set(points)
    lines = [set(line) for line in lines]

    # (P1) Cada par de puntos está en exactamente una recta
    for a, b in combinations(points, 2):
        incident = [line for line in lines if a in line and b in line]
        if len(incident) != 1:
            return False, f"P1 falla: los puntos {a},{b} están en {len(incident)} rectas"

    # (P2) Cada par de rectas se corta en exactamente un punto
    for r, s in combinations(lines, 2):
        meet = r & s
        if len(meet) != 1:
            return False, f"P2 falla: las rectas {r},{s} se cortan en {len(meet)} puntos"

    # (P3) Existen cuatro puntos en posición general (ningún trío colineal)
    if not has_quadrangle(points, lines):
        return False, "P3 falla: no existen cuatro puntos en posición general"

    return True, "La estructura es un plano proyectivo"


def has_quadrangle(points, lines):
    """
    Comprueba si existen cuatro puntos sin ningún trío colineal.

    Args:
        points: Conjunto de puntos.
        lines: Lista de rectas como conjuntos de puntos.

    Returns:
        True si existe tal cuaterna de puntos.
    """
    for four in combinations(points, 4):
        collinear = any(
            set(trio) <= line for trio in combinations(four, 3) for line in lines
        )
        if not collinear:
            return True
    return False


def main():
    # Plano de Fano, PG(2,2): 7 puntos y 7 rectas; cada recta tiene 3 puntos
    # y por cada punto pasan 3 rectas.
    fano_points = {1, 2, 3, 4, 5, 6, 7}
    fano_lines = [
        {1, 2, 3}, {1, 4, 5}, {1, 6, 7},
        {2, 4, 6}, {2, 5, 7},
        {3, 4, 7}, {3, 5, 6},
    ]

    is_valid, message = is_projective_plane(fano_points, fano_lines)
    print(f"Plano de Fano: {message} -> {is_valid}")

    # Geometría de tres puntos (el «triángulo»): cumple P1, pero no P3,
    # porque solo tiene tres puntos.
    triangle_points = {1, 2, 3}
    triangle_lines = [{1, 2}, {1, 3}, {2, 3}]

    is_valid, message = is_projective_plane(triangle_points, triangle_lines)
    print(f"Geometría de tres puntos: {message} -> {is_valid}")


if __name__ == "__main__":
    main()
