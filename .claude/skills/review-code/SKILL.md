---
name: review-code
description: Revisa código en documentos LaTeX para asegurar convenciones de nombrado. Usa cuando el usuario mencione revisar código, verificar nombres de variables/funciones, o validar estilo de código en documentos.
allowed-tools:
  - Read
  - Grep
  - Glob
---

# Revisión de Código en Documentos LaTeX

## Reglas de Estilo

### 1. Nombres de código en inglés
Todo el código (nombres de funciones, clases, variables, métodos) debe estar escrito en **inglés**.

**Correcto:**
- `TwoElementField`
- `approximate_sqrt`
- `verify_axioms`
- `RationalNumber`

**Incorrecto:**
- `CuerpoDosElementos`
- `aproximar_raiz`
- `verificar_axiomas`
- `NumeroRacional`

### 2. Comentarios en español
Los comentarios dentro del código deben estar en **español** para mantener consistencia con el texto del libro.

**Correcto:**
```python
# Calcula la aproximación de la raíz cuadrada
def approximate_sqrt(n, iterations):
    pass
```

**Incorrecto:**
```python
# Calculate the square root approximation
def approximate_sqrt(n, iterations):
    pass
```

### 3. Docstrings en español
La documentación de funciones (docstrings) debe estar en español.

```python
def verify_axioms(field):
    """
    Verifica que el cuerpo satisface todos los axiomas.

    Args:
        field: Instancia del cuerpo a verificar.

    Returns:
        True si todos los axiomas se cumplen.
    """
    pass
```

## Instrucciones

1. Busca archivos `.tex` en el directorio especificado
2. Identifica bloques de código:
   - Ambientes `lstlisting`, `verbatim`, `minted`
   - Referencias con `\texttt{}`
   - Código inline con backticks
3. Para cada bloque de código, verifica:
   - Nombres de identificadores (clases, funciones, variables) estén en inglés
   - Comentarios (`#`, `//`, `/* */`) estén en español
4. Reporta inconsistencias con sugerencias de corrección

## Patrones a buscar

| Tipo | Patrón | Idioma esperado |
|------|--------|-----------------|
| Nombres de clase | `class NombreClase` | Inglés |
| Nombres de función | `def nombre_funcion` | Inglés |
| Variables | `variable = valor` | Inglés |
| Comentarios | `# comentario` | Español |
| Docstrings | `"""texto"""` | Español |

## Ejemplo de reporte

```
## Revisión de código: chapter1.tex

### Problemas encontrados:

1. Línea 118: `CuerpoDosElementos` → Sugerencia: `TwoElementField`
2. Línea 45: Comentario en inglés → Traducir a español

### Resumen:
- 1 nombre de clase en español (debe ser inglés)
- 1 comentario en inglés (debe ser español)
```
