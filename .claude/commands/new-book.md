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

9. Actualiza el `Makefile`:
   - Agrega el nombre del directorio a la variable `BOOKS`

10. Actualiza `.github/workflows/books.yml` (**paso crítico**):
    - Agrega una entrada nueva a la matriz `matrix.book`, siguiendo el formato
      de las existentes:
      ```yaml
      - name: nombre_directorio
        dir: nombre_directorio
        pdf: nombre_directorio.pdf
        emoji: "📘"
      ```
    - Elige un emoji que no esté en uso por otro libro.
    - Sin este paso el libro **no se compila en GitHub Actions** y el PDF nunca
      llega a la rama `pdfs`, por lo que el enlace «Descargar» del `README.md`
      queda roto (404).

11. Verifica que el libro compila localmente con `./compile.sh nombre_directorio`
    y revisa que no haya errores ni cajas desbordadas:
    ```bash
    cd nombre_directorio && pdflatex -interaction=nonstopmode main.tex | grep -E 'Overfull|^!'
    ```
    Ten en cuenta que `compile.sh` redirige y luego borra los logs, así que una
    ejecución «exitosa» del script no garantiza que la tipografía esté bien.

12. Muestra un resumen de lo creado y los próximos pasos.

## Puntos de registro de un libro

Un libro nuevo debe quedar registrado en **cinco** lugares. Si falta alguno, el
libro queda a medias:

| Archivo | Qué agregar | Si falta |
|---------|-------------|----------|
| `compile.sh` | array `BOOKS` y `show_help()` | `./compile.sh <libro>` falla |
| `Makefile` | variable `BOOKS` | `make` no compila el libro |
| `.github/workflows/books.yml` | entrada en `matrix.book` | no se compila en CI ni se publica el PDF |
| `README.md` | tabla de libros, estructura y roadmap | el libro no aparece documentado |
| `main.tex` del libro | `\title{}` y `\input{chapters/...}` | el libro no compila |

## Ejemplo de uso

```
/new-book algebra_lineal "Álgebra Lineal" "Vectores, matrices y transformaciones"
```

```
/new-book calculo "Cálculo Diferencial e Integral"
```
