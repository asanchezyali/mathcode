# Compilar Libro

Compila un libro o todos los libros del proyecto.

## Argumentos

- `$ARGUMENTS` - Nombre del libro a compilar (opcional, si no se proporciona compila todos)

## Instrucciones

**IMPORTANTE**: Siempre ejecutar desde el directorio raíz del proyecto `/Users/asanchezyali/Documents/Own/mathcode`.

1. Si se proporciona un argumento:
   - Verifica que el directorio del libro existe
   - Ejecuta: `cd /Users/asanchezyali/Documents/Own/mathcode && ./compile.sh nombre_libro`
   - Reporta el resultado de la compilación

2. Si no se proporciona argumento:
   - Detecta el libro actual basándose en el directorio de trabajo
   - Ejecuta: `cd /Users/asanchezyali/Documents/Own/mathcode && ./compile.sh nombre_libro`
   - Reporta el resultado de cada compilación

3. Si hay errores de compilación:
   - Muestra los errores relevantes del log
   - Sugiere posibles soluciones

## Libros disponibles

- `math_fundamentals`
- `geometry`
- `deep_learning`
- `machine_learning`
- `llms`
- `inferencial_statistics`
- `src`

## Ejemplo de uso

```
/compile math_fundamentals
```

```
/compile
```
