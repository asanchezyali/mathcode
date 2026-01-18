# Instrucciones para Claude Code

## Compilación de libros LaTeX

Para compilar los libros de este proyecto, **siempre** usar el script `compile.sh` desde el directorio raíz del proyecto:

```bash
# Compilar un libro específico
./compile.sh math_fundamentals
./compile.sh geometry
./compile.sh deep_learning

# Compilar todos los libros
./compile.sh --all

# Limpiar archivos auxiliares
./compile.sh --clean
```

**IMPORTANTE**: No usar `pdflatex` directamente. El script `compile.sh` maneja correctamente:
- Múltiples pasadas de pdflatex
- Bibliografía con biber
- Glosarios con makeglossaries
- Índices con makeindex
- Limpieza de archivos auxiliares

## Estructura del proyecto

Cada libro tiene la siguiente estructura:
```
libro/
├── main.tex           # Documento principal
├── preamble.tex       # Configuración y paquetes
├── chapters/          # Capítulos del libro
├── code/              # Archivos de código (Python, etc.)
├── images/            # Imágenes
├── bibliography/      # Referencias bibliográficas
├── frontmatter/       # Portada, dedicatoria, prefacio
└── backmatter/        # Apéndices, glosario, índice
```

## Convenciones de código

Ver el skill `review-code` para las convenciones de nombrado de código en documentos LaTeX.
