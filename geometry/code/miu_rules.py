def aplicar_reglas(cadena):
    """
    Recibe una cadena del sistema MIU y devuelve un conjunto
    con todas las cadenas que se pueden derivar de ella en un paso.
    """
    derivaciones = set()

    # Regla 1: xI -> xIU
    if cadena.endswith('I'):
        derivaciones.add(cadena + 'U')

    # Regla 2: Mx -> Mxx
    if cadena.startswith('M'):
        x = cadena[1:]
        derivaciones.add('M' + x + x)

    # Regla 3: III -> U (Buscamos en todas las posiciones posibles)
    for i in range(len(cadena) - 2):
        if cadena[i:i+3] == 'III':
            # Reconstruimos la cadena reemplazando III por U
            nueva = cadena[:i] + 'U' + cadena[i+3:]
            derivaciones.add(nueva)

    # Regla 4: UU -> eliminar (Buscamos en todas las posiciones posibles)
    for i in range(len(cadena) - 1):
        if cadena[i:i+2] == 'UU':
            # Reconstruimos la cadena eliminando UU
            nueva = cadena[:i] + cadena[i+2:]
            derivaciones.add(nueva)

    return derivaciones

# Prueba del axioma inicial
axioma = "MI"
hijos = aplicar_reglas(axioma)
print(f"Del axioma '{axioma}' se derivan: {hijos}")
