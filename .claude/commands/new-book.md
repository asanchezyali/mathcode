# Crear Nuevo Libro

Crea un nuevo libro basado en el template del proyecto.

## Argumentos

- `$ARGUMENTS` - Nombre del directorio y título del libro en formato: `nombre_directorio "Título del Libro" "Subtítulo opcional"`

## Instrucciones

1. Parsea los argumentos:
   - Primer argumento: nombre del directorio (snake_case, ej: `algebra_lineal`)
   - Segundo argumento: título del libro (ej: "Álgebra Lineal")
   - Tercer argumento (opcional): subtítulo (ej: "Vectores, matrices y transformaciones")

2. Copia el directorio `template/` al nuevo directorio con el nombre proporcionado.

3. Actualiza `main.tex`:
   - Cambia el título del libro por el proporcionado

4. Actualiza `frontmatter/titlepage.tex`:
   - Cambia el subtítulo si se proporcionó uno

5. Crea un `chapters/chapter1.tex` vacío con la estructura básica:
   - Un capítulo llamado "Introducción"
   - Una sección vacía

6. Limpia los archivos de ejemplo:
   - Vacía `backmatter/glossary.tex` dejando solo comentarios
   - Vacía `bibliography/references.bib` dejando solo ejemplos comentados

7. Actualiza el `README.md` del proyecto:
   - Agrega el nuevo libro a la tabla de libros
   - Agrega el libro a la estructura del proyecto
   - Agrega el libro al roadmap

8. Actualiza `compile.sh`:
   - Agrega el nombre del directorio al array `BOOKS`
   - Agrega el libro a la lista de libros disponibles en `show_help()`

9. Muestra un resumen de lo creado y los próximos pasos.

## Ejemplo de uso

```
/new-book algebra_lineal "Álgebra Lineal" "Vectores, matrices y transformaciones"
```

```
/new-book calculo "Cálculo Diferencial e Integral"
```
