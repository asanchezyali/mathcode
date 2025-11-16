# 📚 Apuntes de Inteligencia Artificial

[![Compilación de Libros](https://github.com/asanchezyali/machine-learning-es/workflows/Build%20LaTeX%20Books/badge.svg)](https://github.com/asanchezyali/machine-learning-es/actions)
[![Licencia](https://img.shields.io/badge/Licencia-MIT-blue.svg)](LICENSE)

> **Notas de estudio sobre Inteligencia Artificial en español**

Este repositorio contiene mis apuntes y notas de estudio sobre diversos temas de Inteligencia Artificial. Son principalmente resúmenes de artículos, papers, libros y cursos que he estudiado.

## ⚠️ Importante

Estos materiales son:
- 📝 **Notas de estudio personales**, no libros completos
- 🔬 **Resúmenes de papers y artículos**, no contenido 100% original
- 🚧 **Trabajo en progreso**, se actualizan constantemente
- 🎓 **Recursos educativos**, compartidos con la comunidad

## 📖 Contenido

### Libros (en desarrollo)

**🧠 Deep Learning** - Elementos de Programación Diferenciable
Notas sobre diferenciación automática, backpropagation y optimización
📥 [Descargar PDF](../../raw/pdfs/deep_learning.pdf)

**🤖 Machine Learning** - Aprendizaje Computacional
Apuntes sobre teoría del aprendizaje estadístico y algoritmos clásicos
📥 [Descargar PDF](../../raw/pdfs/machine_learning.pdf)

**💬 LLMs** - Modelos de Lenguaje de Gran Escala
Notas sobre transformers, fine-tuning y aplicaciones de LLMs
📥 [Descargar PDF](../../raw/pdfs/llms.pdf)

**📊 Estadística Inferencial** - Fundamentos Estadísticos
Apuntes sobre inferencia estadística y análisis bayesiano
📥 [Descargar PDF](../../raw/pdfs/inferencial_statistics.pdf)

### Artículos

Artículos cortos sobre temas específicos ([ver artículos](articles/)):
- 📄 [Deep Learning](../../raw/pdfs/articles/dl.pdf)
- 📄 [Machine Learning](../../raw/pdfs/articles/ml.pdf)
- 📄 [Estadística Inferencial](../../raw/pdfs/articles/inferencial_statistics.pdf)

## 🚀 Compilar

### Requisitos

- LaTeX (TeX Live o MiKTeX)
- `pdflatex`, `biber`, `makeglossaries`, `makeindex`

**Instalar en macOS:**
```bash
brew install --cask mactex
```

**Instalar en Ubuntu/Debian:**
```bash
sudo apt-get install texlive-full
```

### Compilar todos los libros

```bash
git clone https://github.com/asanchezyali/machine-learning-es.git
cd machine-learning-es
./compile.sh
```

### Compilar un libro específico

```bash
./compile.sh deep_learning
./compile.sh machine_learning
./compile.sh llms
./compile.sh inferencial_statistics
```

### Compilar artículos

```bash
cd articles
./compile.sh              # Todos los artículos
./compile.sh dl.tex       # Artículo específico
```

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Si encuentras errores o quieres agregar contenido:

1. Haz fork del repositorio
2. Crea una rama (`git checkout -b fix/error-capitulo-3`)
3. Haz commit de tus cambios (`git commit -m 'Corregir error en ecuación'`)
4. Push a la rama (`git push origin fix/error-capitulo-3`)
5. Abre un Pull Request

### Guías

- Usa español neutro (LATAM)
- Cita las fuentes apropiadamente
- Usa `\parencite{}` para referencias bibliográficas
- Compila sin errores antes de hacer PR

## 📁 Estructura

```
machine-learning-es/
├── deep_learning/        # Notas de deep learning
├── machine_learning/     # Notas de ML clásico
├── llms/                 # Notas de LLMs
├── inferencial_statistics/  # Notas de estadística
├── src/                  # Material adicional
├── articles/             # Artículos cortos
├── compile.sh            # Script de compilación
└── README.md
```

## 📜 Licencia

MIT License - Ver [LICENSE](LICENSE) para más detalles.

Puedes usar, modificar y compartir este material libremente, dando crédito apropiado.

## 👤 Autor

**Alejandro Sánchez Yalí**
[@asanchezyali](https://github.com/asanchezyali)

## 🙏 Agradecimientos

Este material es posible gracias a:
- Los autores de los papers y libros que he estudiado
- La comunidad de LaTeX
- Todos los que han contribuido con correcciones y sugerencias

---

<p align="center">
  <sub>Compartido con la comunidad • Hecho con LaTeX ❤️</sub>
</p>
