#!/bin/bash

# LaTeX Articles Compilation Script
# Compiles article .tex files in the articles directory
# Usage: ./compile.sh [options] [filename.tex]

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

show_help() {
    echo "Usage: ./compile.sh [options] [filename.tex]"
    echo ""
    echo "Options:"
    echo "  --all       Compile all .tex articles (default if no arguments)"
    echo "  --clean     Remove all generated files"
    echo "  --help      Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./compile.sh                   # Compile all articles"
    echo "  ./compile.sh --all             # Compile all articles"
    echo "  ./compile.sh dl.tex            # Compile specific article"
    echo "  ./compile.sh --clean           # Remove all generated files"
}

clean_aux_files() {
    local basename="$1"
    echo -e "${BLUE}Cleaning auxiliary files for ${basename}...${NC}"

    # Remove all auxiliary files but keep PDF
    rm -f "${basename}.aux" "${basename}.lof" "${basename}.log" "${basename}.lot" \
          "${basename}.fls" "${basename}.out" "${basename}.toc" "${basename}.fmt" \
          "${basename}.fot" "${basename}.cb" "${basename}.cb2" "${basename}.bbl" \
          "${basename}.bcf" "${basename}.blg" "${basename}.run.xml" \
          "${basename}.fdb_latexmk" "${basename}.synctex" "${basename}.synctex.gz" \
          "${basename}.pdfsync" "${basename}.nav" "${basename}.pre" "${basename}.snm" \
          "${basename}.vrb" "${basename}.acn" "${basename}.acr" "${basename}.glg" \
          "${basename}.glo" "${basename}.gls" "${basename}.glsdefs" "${basename}.lzo" \
          "${basename}.lzs" "${basename}.brf" "${basename}.lol" "${basename}.idx" \
          "${basename}.ilg" "${basename}.ind" "${basename}.maf" "${basename}.mlf" \
          "${basename}.mlt" "${basename}.mtc"* "${basename}.slf"* "${basename}.slt"* \
          "${basename}.stc"* "${basename}.mw" "${basename}.nlg" "${basename}.nlo" \
          "${basename}.nls" "${basename}.pax" "${basename}.pdfpc" "${basename}.wrt" \
          "${basename}.sout" "${basename}.sympy" "${basename}.dpth" "${basename}.md5" \
          "${basename}.auxlock" "${basename}.tdo" "${basename}.xdy" "${basename}.dvi" \
          "${basename}.xdv" 2>/dev/null

    # Remove minted directories
    rm -rf "_minted-${basename}" 2>/dev/null
}

clean_all() {
    echo -e "${YELLOW}Removing all generated files from articles directory...${NC}"

    # Remove all LaTeX auxiliary files
    rm -f *.aux *.lof *.log *.lot *.fls *.out *.toc *.fmt *.fot *.cb *.cb2 \
          *.bbl *.bcf *.blg *.run.xml *.fdb_latexmk *.synctex *.synctex.gz \
          *.pdfsync *.nav *.pre *.snm *.vrb *.acn *.acr *.glg *.glo *.gls \
          *.glsdefs *.ist *.lzo *.lzs *.brf *.lol *.idx *.ilg *.ind *.maf *.mlf \
          *.mlt *.mtc* *.slf* *.slt* *.stc* *.mw *.nlg *.nlo *.nls *.pax \
          *.pdfpc *.wrt *.sout *.sympy *.dpth *.md5 *.auxlock *.tdo *.xdy \
          *.dvi *.xdv 2>/dev/null

    # Remove PDFs
    rm -f *.pdf 2>/dev/null

    # Remove minted directories
    rm -rf _minted* 2>/dev/null

    echo -e "${GREEN}All generated files removed from articles directory!${NC}"
}

compile_article() {
    local file="$1"
    local basename="${file%.tex}"

    if [ ! -f "$file" ]; then
        echo -e "${RED}✗ File not found: ${file}${NC}"
        return 1
    fi

    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}Compiling article: ${CYAN}${file}${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

    # First pass: Generate aux files
    echo -e "${BLUE}[1/4]${NC} Running pdflatex (first pass)..."
    pdflatex -interaction=nonstopmode "$file" > pdflatex1_${basename}.log 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Error on first pdflatex pass${NC}"
        echo -e "${YELLOW}  Check pdflatex1_${basename}.log for details${NC}"
        return 1
    fi

    # Run bibtex if .bib files exist
    if ls core/*.bib 1> /dev/null 2>&1; then
        echo -e "${BLUE}[2/4]${NC} Processing bibliography with bibtex..."
        bibtex "$basename" > /dev/null 2>&1 || echo -e "${YELLOW}  ⚠ BibTeX warnings (ignoring)${NC}"
    else
        echo -e "${BLUE}[2/4]${NC} Skipping bibtex (no bibliography found)"
    fi

    # Second pass: Incorporate bibliography
    echo -e "${BLUE}[3/4]${NC} Running pdflatex (second pass)..."
    pdflatex -interaction=nonstopmode "$file" > pdflatex2_${basename}.log 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Error on second pdflatex pass${NC}"
        echo -e "${YELLOW}  Check pdflatex2_${basename}.log for details${NC}"
        return 1
    fi

    # Third pass: Final resolution of references
    echo -e "${BLUE}[4/4]${NC} Running pdflatex (final pass)..."
    pdflatex -interaction=nonstopmode "$file" > pdflatex3_${basename}.log 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Error on final pdflatex pass${NC}"
        echo -e "${YELLOW}  Check pdflatex3_${basename}.log for details${NC}"
        return 1
    fi

    # Check if PDF was generated
    if [ -f "${basename}.pdf" ]; then
        echo -e "${GREEN}✓ Successfully compiled ${basename}.pdf${NC}"

        # Show file size
        local size=$(du -h "${basename}.pdf" | cut -f1)
        echo -e "${CYAN}  Size: ${size}${NC}"
    else
        echo -e "${RED}✗ PDF not generated${NC}"
        return 1
    fi

    # Clean auxiliary files but keep PDF
    echo -e "${BLUE}Cleaning auxiliary files...${NC}"
    clean_aux_files "$basename"

    # Clean up compilation logs
    rm -f pdflatex1_${basename}.log pdflatex2_${basename}.log pdflatex3_${basename}.log

    echo -e "${GREEN}✓ Done!${NC}"
    echo ""
}

compile_all_articles() {
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  Compiling All Articles               ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
    echo ""

    local compiled=0
    local failed=0

    shopt -s nullglob
    tex_files=(*.tex)

    if [ ${#tex_files[@]} -eq 0 ]; then
        echo -e "${RED}No .tex files found in articles directory${NC}"
        return 1
    fi

    for file in "${tex_files[@]}"; do
        if compile_article "$file"; then
            ((compiled++))
        else
            ((failed++))
        fi
    done

    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  Compilation Summary                  ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
    echo -e "${GREEN}✓ Compiled: ${compiled}${NC}"
    if [ $failed -gt 0 ]; then
        echo -e "${RED}✗ Failed: ${failed}${NC}"
    fi
    echo ""
}

# Parse options
case "$1" in
    --clean)
        clean_all
        exit 0
        ;;
    --help)
        show_help
        exit 0
        ;;
    --all|"")
        # Compile all articles (default if no arguments)
        compile_all_articles
        exit 0
        ;;
    *)
        # Check if argument is a .tex file
        if [[ "$1" == *.tex ]]; then
            compile_article "$1"
        else
            echo -e "${RED}✗ Invalid argument: $1${NC}"
            echo ""
            echo -e "${CYAN}Run './compile.sh --help' for usage information${NC}"
            exit 1
        fi
        ;;
esac
