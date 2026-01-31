# Math & Code

[![Compilar Libros](https://github.com/asanchezyali/mathcode/workflows/Build%20LaTeX%20Books/badge.svg)](https://github.com/asanchezyali/mathcode/actions)
[![Licencia](https://img.shields.io/badge/Licencia-MIT-blue.svg)](LICENSE)
[![LaTeX](https://img.shields.io/badge/LaTeX-TeX%20Live-008080.svg)](https://www.latex-project.org/)

Colección de libros y artículos sobre **matemáticas** y **programación**, explorando los fundamentos teóricos y su aplicación práctica en inteligencia artificial, estadística y geometría computacional.

## Objetivo

Construir recursos educativos que conecten la teoría matemática con la implementación en código, facilitando la comprensión de conceptos complejos a través de ejemplos prácticos y visualizaciones.

## Contenido

### Libros

| Libro | Descripción | PDF |
|-------|-------------|-----|
| **Fundamentos de las Matemáticas** | Compilación de ideas fundamentales para el desarrollo de matemáticas avanzadas | [Descargar](../../raw/pdfs/math_fundamentals.pdf) |
| **Geometría Plana** | Sistemas formales, axiomas y geometría computacional | [Descargar](../../raw/pdfs/geometry.pdf) |
| **Deep Learning** | Diferenciación automática, backpropagation y optimización | [Descargar](../../raw/pdfs/deep_learning.pdf) |
| **Machine Learning** | Teoría del aprendizaje estadístico y algoritmos | [Descargar](../../raw/pdfs/machine_learning.pdf) |
| **LLMs** | Transformers, fine-tuning y modelos de lenguaje | [Descargar](../../raw/pdfs/llms.pdf) |
| **Estadística Inferencial** | Inferencia estadística y análisis bayesiano | [Descargar](../../raw/pdfs/inferencial_statistics.pdf) |
| **Métodos Numéricos** | Algoritmos, análisis de errores y aplicaciones | [Descargar](../../raw/pdfs/numerical_methods.pdf) |

### Artículos

Artículos cortos sobre temas específicos ([ver todos](articles/)):
- [Deep Learning](../../raw/pdfs/articles/dl.pdf)
- [Machine Learning](../../raw/pdfs/articles/ml.pdf)
- [Estadística Inferencial](../../raw/pdfs/articles/inferencial_statistics.pdf)

## Compilar

### Requisitos

- LaTeX (TeX Live o MiKTeX)
- `pdflatex`, `biber`, `makeglossaries`, `makeindex`

```bash
# macOS
brew install --cask mactex

# Ubuntu/Debian
sudo apt-get install texlive-full
```

### Compilación

```bash
git clone https://github.com/asanchezyali/mathcode.git
cd mathcode

# Compilar todos los libros
./compile.sh

# Compilar un libro específico
./compile.sh math_fundamentals
./compile.sh geometry
./compile.sh deep_learning
./compile.sh machine_learning

# Compilar artículos
cd articles && ./compile.sh
```

## Estructura

```
mathcode/
├── math_fundamentals/      # Fundamentos de las matemáticas
├── geometry/               # Geometría plana
├── deep_learning/          # Deep learning
├── machine_learning/       # Machine learning
├── llms/                   # Modelos de lenguaje
├── inferencial_statistics/ # Estadística inferencial
├── numerical_methods/      # Métodos numéricos
├── articles/               # Artículos cortos
├── template/               # Plantilla para nuevos libros
├── src/                    # Material compartido
└── compile.sh              # Script de compilación
```

Cada libro sigue la estructura:
```
libro/
├── chapters/       # Capítulos del libro
├── code/           # Código fuente y ejemplos
├── frontmatter/    # Portada, prefacio, dedicatoria
├── backmatter/     # Apéndices, glosario
├── bibliography/   # Referencias bibliográficas
└── main.tex        # Documento principal
```

## Crear un Nuevo Libro

Usa el directorio `template/` como base para nuevos libros:

```bash
cp -r template/ nuevo_libro/
cd nuevo_libro/
# Edita main.tex y cambia el título
# Agrega capítulos en chapters/
```

## Contribuir

1. Fork del repositorio
2. Crear rama: `git checkout -b feature/nuevo-capitulo`
3. Commit: `git commit -m 'Agregar capítulo sobre X'`
4. Push: `git push origin feature/nuevo-capitulo`
5. Abrir Pull Request

**Guías de estilo:**
- Español neutro (LATAM)
- Citar fuentes con `\parencite{}`
- Verificar compilación antes del PR

## Roadmap

- [ ] Completar libro de Fundamentos de las Matemáticas
- [ ] Completar libro de Geometría Plana
- [ ] Completar libro de Métodos Numéricos
- [ ] Agregar ejemplos de código en Python
- [ ] Crear visualizaciones interactivas
- [ ] Traducción al inglés

## Licencia

MIT License - Ver [LICENSE](LICENSE)

## Autores

- **Alejandro Sánchez Yalí** - Matemático, Universidad de Antioquia - [@asanchezyali](https://github.com/asanchezyali)
- **Juan Pablo Restrepo** - Matemático, Universidad de Antioquia
