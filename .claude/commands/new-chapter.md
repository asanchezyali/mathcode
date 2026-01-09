# Agregar Nuevo Capítulo

Agrega un nuevo capítulo a un libro existente.

## Argumentos

- `$ARGUMENTS` - Nombre del libro y título del capítulo en formato: `nombre_libro "Título del Capítulo"`

## Instrucciones

1. Parsea los argumentos:
   - Primer argumento: nombre del directorio del libro (ej: `math_fundamentals`)
   - Segundo argumento: título del capítulo (ej: "Teoría de Conjuntos")

2. Verifica que el directorio del libro existe.

3. Cuenta los capítulos existentes en `chapters/` para determinar el número del nuevo capítulo.

4. Crea el archivo `chapters/chapterN.tex` con:
   - El título del capítulo proporcionado
   - Una sección de introducción vacía
   - Placeholders para definiciones, teoremas y ejercicios

5. Actualiza `main.tex` del libro:
   - Agrega `\input{chapters/chapterN.tex}` después del último capítulo

6. Muestra un resumen con:
   - Archivo creado
   - Número de capítulo
   - Próximos pasos

## Ejemplo de uso

```
/new-chapter math_fundamentals "Teoría de Conjuntos"
```

```
/new-chapter geometry "Triángulos y sus Propiedades"
```
