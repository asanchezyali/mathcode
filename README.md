# 🤖 Apuntes de Inteligencia Artificial en Español

[![Compilación de Libros](https://github.com/asanchezyali/machine-learning-es/workflows/Build%20LaTeX%20Books/badge.svg)](https://github.com/asanchezyali/machine-learning-es/actions)
[![Licencia](https://img.shields.io/badge/Licencia-MIT-blue.svg)](LICENSE)
[![Contribuidores](https://img.shields.io/github/contributors/asanchezyali/machine-learning-es)](https://github.com/asanchezyali/machine-learning-es/graphs/contributors)

> **Una colección completa de apuntes teóricos sobre Inteligencia Artificial para la comunidad latinoamericana**

## 🎯 Misión

Democratizar el conocimiento de Inteligencia Artificial en español, creando recursos educativos de alta calidad, gratuitos y accesibles para **un millón de estudiantes y profesionales** en América Latina y el mundo hispanohablante.

## 📚 Libros Disponibles

Este repositorio contiene una colección de libros técnicos sobre diferentes áreas de la Inteligencia Artificial:

### 🧠 Deep Learning
**Elementos de Programación Diferenciable**
- Fundamentos de diferenciación automática
- Arquitecturas de redes neuronales modernas
- Técnicas de optimización basada en gradientes
- Aplicaciones prácticas

📖 [Ver libro](deep_learning/) | 📥 [Descargar PDF](../../raw/pdfs/deep_learning.pdf)

### 🤖 Machine Learning
**Aprendizaje Computacional**
- Teoría del aprendizaje estadístico
- Algoritmos clásicos de ML
- Regresión y clasificación
- Evaluación de modelos

📖 [Ver libro](machine_learning/) | 📥 [Descargar PDF](../../raw/pdfs/machine_learning.pdf)

### 💬 LLMs
**Modelos de Lenguaje de Gran Escala**
- Arquitecturas transformer
- Fine-tuning y adaptación
- Técnicas de prompting
- Aplicaciones de LLMs

📖 [Ver libro](llms/) | 📥 [Descargar PDF](../../raw/pdfs/llms.pdf)

### 📊 Estadística Inferencial
**Fundamentos Estadísticos para IA**
- Inferencia estadística
- Pruebas de hipótesis
- Intervalos de confianza
- Análisis bayesiano

📖 [Ver libro](inferencial_statistics/) | 📥 [Descargar PDF](../../raw/pdfs/inferencial_statistics.pdf)

### 📝 Artículos
Artículos cortos sobre temas específicos de IA
- Tutoriales
- Casos de estudio
- Conceptos fundamentales

📖 [Ver artículos](articles/)

## 🚀 Inicio Rápido

### Requisitos Previos

Para compilar los libros, necesitas tener instalado:
- LaTeX (TeX Live 2025 o superior)
- `pdflatex`
- `biber`
- `makeglossaries`
- `makeindex`

**macOS:**
```bash
brew install --cask mactex
```

**Ubuntu/Debian:**
```bash
sudo apt-get install texlive-full
```

**Windows:**
Descarga e instala [MiKTeX](https://miktex.org/) o [TeX Live](https://www.tug.org/texlive/)

### Compilar Todos los Libros

```bash
git clone https://github.com/asanchezyali/machine-learning-es.git
cd machine-learning-es
./compile.sh
```

### Compilar un Libro Específico

```bash
# Compilar solo Deep Learning
./compile.sh deep_learning

# Compilar solo Machine Learning
./compile.sh machine_learning

# Compilar solo LLMs
./compile.sh llms

# Compilar solo Estadística Inferencial
./compile.sh inferencial_statistics
```

### Compilar Artículos

```bash
cd articles
./compile.sh                    # Compilar todos los artículos
./compile.sh dl.tex             # Compilar artículo específico
```

### Limpiar Archivos Generados

```bash
./compile.sh --clean            # Limpiar archivos de compilación
```

## 🤝 Cómo Contribuir

¡Tu contribución es bienvenida! Este proyecto está abierto a la comunidad y queremos que crezcas junto con nosotros.

### Formas de Contribuir

1. **📝 Escribir contenido**
   - Agregar nuevos capítulos
   - Mejorar explicaciones existentes
   - Traducir contenido técnico
   - Crear ejemplos prácticos

2. **🐛 Reportar errores**
   - Errores tipográficos
   - Errores matemáticos
   - Problemas de compilación
   - Enlaces rotos

3. **💡 Proponer mejoras**
   - Nuevos temas
   - Mejoras de estructura
   - Recursos adicionales
   - Ejercicios y problemas

4. **🎨 Mejorar diseño**
   - Figuras y diagramas
   - Formato LaTeX
   - Estilo visual

### Proceso de Contribución

1. **Fork** este repositorio
2. **Crea** una rama para tu contribución:
   ```bash
   git checkout -b feature/nuevo-capitulo
   ```
3. **Realiza** tus cambios y commitea:
   ```bash
   git add .
   git commit -m "✨ Agregar capítulo sobre transformers"
   ```
4. **Push** a tu fork:
   ```bash
   git push origin feature/nuevo-capitulo
   ```
5. **Abre** un Pull Request describiendo tus cambios

### Guías de Estilo

#### Para Contenido
- ✅ Usa lenguaje claro y accesible
- ✅ Incluye ejemplos prácticos
- ✅ Cita las fuentes apropiadamente
- ✅ Usa notación matemática estándar
- ✅ Escribe en español neutro (LATAM)

#### Para Código LaTeX
- ✅ Usa `\parencite{}` en lugar de `\citep{}`
- ✅ Organiza el contenido en capítulos
- ✅ Usa comandos definidos en `preamble.tex`
- ✅ Compila sin errores antes de hacer PR

#### Para Commits
Usa [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` Nueva característica
- `fix:` Corrección de error
- `docs:` Cambios en documentación
- `style:` Formato, sin cambios de código
- `refactor:` Refactorización de código
- `test:` Agregar tests

## 📁 Estructura del Proyecto

```
machine-learning-es/
├── deep_learning/              # Libro de Deep Learning
│   ├── chapters/               # Capítulos del libro
│   ├── frontmatter/            # Páginas preliminares
│   ├── backmatter/             # Apéndices y glosario
│   ├── bibliography/           # Referencias bibliográficas
│   ├── main.tex                # Archivo principal
│   └── preamble.tex            # Configuración LaTeX
│
├── machine_learning/           # Libro de Machine Learning
│   └── [misma estructura]
│
├── llms/                       # Libro de LLMs
│   └── [misma estructura]
│
├── inferencial_statistics/     # Libro de Estadística
│   └── [misma estructura]
│
├── src/                        # Libro de Redes Neuronales
│   └── [misma estructura]
│
├── articles/                   # Artículos cortos
│   ├── core/                   # Plantilla y recursos
│   ├── compile.sh              # Script de compilación
│   └── *.tex                   # Artículos individuales
│
├── figures/                    # Figuras compartidas
├── compile.sh                  # Script principal de compilación
├── .gitignore                  # Archivos ignorados por Git
└── README.md                   # Este archivo
```

## 🛠️ Scripts de Compilación

### `compile.sh` (Raíz)
Script principal para compilar todos los libros.

**Opciones:**
- `./compile.sh` - Compila todos los libros
- `./compile.sh --all` - Compila todos los libros
- `./compile.sh <libro>` - Compila un libro específico
- `./compile.sh --clean` - Limpia archivos generados
- `./compile.sh --help` - Muestra ayuda

### `articles/compile.sh`
Script para compilar artículos individuales.

**Opciones:**
- `./compile.sh` - Compila todos los artículos
- `./compile.sh <archivo.tex>` - Compila un artículo específico
- `./compile.sh --clean` - Limpia archivos generados

## 🔄 Integración Continua

Los libros se compilan automáticamente con **GitHub Actions** cuando:
- Se hace push a la rama `main`
- Se crea un Pull Request

Los PDFs compilados se suben automáticamente a la rama `pdfs` y están disponibles para descarga.

## 📜 Licencia

Este proyecto está licenciado bajo la [Licencia MIT](LICENSE) - mira el archivo LICENSE para más detalles.

### ¿Qué significa esto?

✅ **Puedes:**
- Usar este material para estudiar
- Compartir con otros estudiantes
- Modificar y adaptar el contenido
- Usar en cursos y talleres (gratuitos o comerciales)

⚠️ **Debes:**
- Dar crédito a los autores originales
- Incluir una copia de la licencia MIT
- Indicar si hiciste cambios

## 🌟 Autores y Contribuidores

### Autor Principal
- **Alejandro Sánchez Yalí** - [@asanchezyali](https://github.com/asanchezyali)

### Contribuidores
Agradecemos a todos los que han contribuido a este proyecto:

<!-- ALL-CONTRIBUTORS-LIST:START -->
<!-- Aquí se agregarán automáticamente los contribuidores -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

¿Quieres aparecer aquí? ¡[Contribuye al proyecto](#-cómo-contribuir)!

## 📞 Contacto y Comunidad

- **Issues:** [Reportar problemas](https://github.com/asanchezyali/machine-learning-es/issues)
- **Discussions:** [Iniciar discusión](https://github.com/asanchezyali/machine-learning-es/discussions)
- **Email:** [tu-email@ejemplo.com](mailto:tu-email@ejemplo.com)

## 🎓 Para Estudiantes

Este material es ideal si:
- 📖 Estás aprendiendo Machine Learning y Deep Learning
- 🎯 Buscas referencias teóricas en español
- 💻 Quieres entender los fundamentos matemáticos
- 🔬 Te interesa la investigación en IA
- 👥 Quieres contribuir a recursos educativos abiertos

## 👨‍🏫 Para Profesores

Este material te permite:
- 📚 Usar como libro de texto en tus cursos
- 📝 Adaptar el contenido a tus necesidades
- 🎓 Asignar lecturas específicas
- 💡 Crear ejercicios basados en el contenido
- 🤝 Contribuir con tu experiencia docente

## 🚀 Roadmap

### Corto Plazo (2024)
- [x] Estructura inicial de libros
- [x] Sistema de compilación automatizado
- [x] Integración continua con GitHub Actions
- [ ] Contenido completo de Deep Learning
- [ ] Contenido completo de Machine Learning
- [ ] 100 contribuidores

### Mediano Plazo (2025)
- [ ] Contenido completo de LLMs
- [ ] Contenido completo de Estadística Inferencial
- [ ] 50+ artículos técnicos
- [ ] Ejercicios y problemas resueltos
- [ ] 1,000 contribuidores
- [ ] 10,000 descargas

### Largo Plazo (2026+)
- [ ] Versiones en otros idiomas
- [ ] Plataforma web interactiva
- [ ] Videos explicativos
- [ ] Notebooks de Jupyter integrados
- [ ] **1,000,000 de usuarios alcanzados**

## ⭐ Apoya el Proyecto

Si este material te ha sido útil, considera:

- ⭐ Dar una estrella a este repositorio
- 🔀 Hacer fork y contribuir
- 📢 Compartir con otros estudiantes
- 💬 Unirte a las discusiones
- 📝 Escribir sobre nosotros en tu blog

## 🙏 Agradecimientos

Agradecemos especialmente a:
- La comunidad de LaTeX por sus excelentes herramientas
- Todos los contribuidores que hacen posible este proyecto
- Las universidades y profesores que usan este material
- Los estudiantes que nos motivan a mejorar cada día

---

<p align="center">
  <strong>Hecho con ❤️ para la comunidad de IA en América Latina</strong>
  <br>
  <sub>¿Tienes preguntas? <a href="https://github.com/asanchezyali/machine-learning-es/discussions">Inicia una discusión</a></sub>
</p>
