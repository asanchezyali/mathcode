# Compilar Libro

Compila un libro o todos los libros del proyecto.

## Argumentos

- `$ARGUMENTS` - Nombre del libro a compilar (opcional, si no se proporciona compila todos)

## Instrucciones

1. Si se proporciona un argumento:
   - Verifica que el directorio del libro existe
   - Ejecuta `./compile.sh nombre_libro`
   - Reporta el resultado de la compilación

2. Si no se proporciona argumento:
   - Ejecuta `./compile.sh` para compilar todos los libros
   - Reporta el resultado de cada compilación

3. Si hay errores de compilación:
   - Muestra los errores relevantes del log
   - Sugiere posibles soluciones

## Ejemplo de uso

```
/compile math_fundamentals
```

```
/compile
```
