"""
Reglas de derivación del sistema formal MIU (acertijo MU de Hofstadter).

Alfabeto: M, I, U.  Axioma inicial: MI.

    Regla 1:  xI    -> xIU     (si termina en I, añadir U)
    Regla 2:  Mx    -> Mxx     (si empieza por M, duplicar el resto)
    Regla 3:  xIIIy -> xUy     (sustituir III por U)
    Regla 4:  xUUy  -> xy      (eliminar UU)

Ejecutar: python3 miu_rules.py
"""


def apply_rules(string):
    """
    Aplica las cuatro reglas del sistema MIU a una cadena.

    Args:
        string: Cadena del sistema MIU.

    Returns:
        Conjunto con todas las cadenas derivables en un solo paso.
    """
    derivations = set()

    # Regla 1: xI -> xIU
    if string.endswith("I"):
        derivations.add(string + "U")

    # Regla 2: Mx -> Mxx
    if string.startswith("M"):
        rest = string[1:]
        derivations.add("M" + rest + rest)

    # Regla 3: III -> U (en todas las posiciones posibles)
    for i in range(len(string) - 2):
        if string[i:i + 3] == "III":
            derivations.add(string[:i] + "U" + string[i + 3:])

    # Regla 4: eliminar UU (en todas las posiciones posibles)
    for i in range(len(string) - 1):
        if string[i:i + 2] == "UU":
            derivations.add(string[:i] + string[i + 2:])

    return derivations


def is_derivable(string):
    """
    Decide si una cadena es alcanzable desde el axioma MI.

    El invariante del sistema es el número de letras I módulo 3: partiendo
    de MI (una sola I) ese residuo nunca llega a ser cero. Por eso MU, que
    no tiene ninguna I, es inalcanzable.

    Args:
        string: Cadena a comprobar.

    Returns:
        True si la cadena puede derivarse desde MI.
    """
    # La cadena debe empezar por M y usar solo el alfabeto del sistema
    if not string.startswith("M") or any(c not in "MIU" for c in string):
        return False

    return string.count("I") % 3 != 0


def main():
    axiom = "MI"
    print(f"Axioma: {axiom}")
    print(f"Derivaciones en un paso: {sorted(apply_rules(axiom))}")

    # Exploración por niveles del árbol de derivaciones
    level = {axiom}
    for depth in range(1, 4):
        level = {child for s in level for child in apply_rules(s)}
        print(f"Nivel {depth}: {len(level)} cadenas")

    print("\nComprobación del invariante (número de I módulo 3):")
    for candidate in ["MU", "MIU", "MIUIU", "MUII", "MIIII"]:
        status = "derivable" if is_derivable(candidate) else "NO derivable"
        print(f"  {candidate:8s} -> {status}")


if __name__ == "__main__":
    main()
