#!/bin/bash

# LaTeX Books Compilation Script
# Compiles book projects with proper handling of bibliography, glossaries, and indexes
# Usage: ./compile.sh [options] [book_name]

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Available books
BOOKS=("deep_learning" "machine_learning" "llms" "inferencial_statistics" "src" "geometry" "math_fundamentals" "numerical_methods")

show_help() {
    echo "Usage: ./compile.sh [options] [book_name]"
    echo ""
    echo "Options:"
    echo "  --all       Compile all books (default if no arguments)"
    echo "  --clean     Remove all generated files in all book directories"
    echo "  --help      Show this help message"
    echo ""
    echo "Available books:"
    echo "  - deep_learning"
    echo "  - machine_learning"
    echo "  - llms"
    echo "  - inferencial_statistics"
    echo "  - src"
    echo "  - geometry"
    echo "  - math_fundamentals"
    echo "  - numerical_methods"
    echo ""
    echo "Examples:"
    echo "  ./compile.sh                   # Compile all books"
    echo "  ./compile.sh --all             # Compile all books"
    echo "  ./compile.sh deep_learning     # Compile deep_learning book"
    echo "  ./compile.sh --clean           # Remove all generated files"
}

clean_aux_files() {
    local basename="$1"
    echo -e "${BLUE}Cleaning auxiliary files for ${basename}...${NC}"

    # Remove ALL files except .tex, .pdf, .bib, .cls, .sty, .ist and keep directories
    find . -maxdepth 1 -type f \
        ! -name "*.tex" \
        ! -name "*.pdf" \
        ! -name "*.bib" \
        ! -name "*.cls" \
        ! -name "*.sty" \
        ! -name "*.ist" \
        -delete 2>/dev/null

    # Remove minted directories
    rm -rf "_minted-"* 2>/dev/null
}

clean_all() {
    echo -e "${YELLOW}Removing all generated files from book directories...${NC}"

    for book in "${BOOKS[@]}"; do
        if [ -d "$book" ]; then
            echo -e "${CYAN}Cleaning ${book}...${NC}"
            cd "$book"

            # Remove ALL files except .tex, .bib, .cls, .sty, .ist (including PDFs)
            find . -maxdepth 1 -type f \
                ! -name "*.tex" \
                ! -name "*.bib" \
                ! -name "*.cls" \
                ! -name "*.sty" \
                ! -name "*.ist" \
                -delete 2>/dev/null

            # Remove minted directories
            rm -rf _minted* 2>/dev/null

            cd ..
        fi
    done

    echo -e "${GREEN}All generated files removed from all book directories!${NC}"
}

compile_book() {
    local book_dir="$1"
    local book_name=$(basename "$book_dir")

    if [ ! -d "$book_dir" ]; then
        echo -e "${RED}Book directory not found: ${book_dir}${NC}"
        return 1
    fi

    if [ ! -f "$book_dir/main.tex" ]; then
        echo -e "${RED}main.tex not found in ${book_dir}${NC}"
        return 1
    fi

    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}Compiling book: ${CYAN}${book_name}${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

    # Save current directory
    local original_dir=$(pwd)

    # Change to book directory
    cd "$book_dir"

    # First pass: Generate aux files
    echo -e "${BLUE}[1/6]${NC} Running pdflatex (first pass)..."
    pdflatex -interaction=nonstopmode main.tex > pdflatex1.log 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Error on first pdflatex pass${NC}"
        echo -e "${YELLOW}  Check pdflatex1.log for details${NC}"
        cd "$original_dir"
        return 1
    fi

    # Run biber if bibliography exists
    if [ -f "bibliography/references.bib" ]; then
        echo -e "${BLUE}[2/6]${NC} Processing bibliography with biber..."
        biber main > /dev/null 2>&1 || echo -e "${YELLOW}  ⚠ Biber warnings (ignoring)${NC}"
    else
        echo -e "${BLUE}[2/6]${NC} Skipping biber (no bibliography found)"
    fi

    # Run makeglossaries for glossary
    if grep -q "\\makeglossaries" main.tex 2>/dev/null; then
        echo -e "${BLUE}[3/6]${NC} Processing glossaries..."
        makeglossaries main > /dev/null 2>&1 || echo -e "${YELLOW}  ⚠ Makeglossaries warnings (ignoring)${NC}"
    else
        echo -e "${BLUE}[3/6]${NC} Skipping glossaries (not found)"
    fi

    # Run makeindex for index
    if [ -f "main.ist" ]; then
        echo -e "${BLUE}[4/6]${NC} Processing index..."
        makeindex -s main.ist main.idx > /dev/null 2>&1 || echo -e "${YELLOW}  ⚠ Makeindex warnings (ignoring)${NC}"
    else
        echo -e "${BLUE}[4/6]${NC} Skipping index (main.ist not found)"
    fi

    # Second pass: Incorporate bibliography and glossaries
    echo -e "${BLUE}[5/6]${NC} Running pdflatex (second pass)..."
    pdflatex -interaction=nonstopmode main.tex > pdflatex2.log 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Error on second pdflatex pass${NC}"
        echo -e "${YELLOW}  Check pdflatex2.log for details${NC}"
        cd "$original_dir"
        return 1
    fi

    # Third pass: Final resolution of references
    echo -e "${BLUE}[6/6]${NC} Running pdflatex (final pass)..."
    pdflatex -interaction=nonstopmode main.tex > pdflatex3.log 2>&1
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ Error on final pdflatex pass${NC}"
        echo -e "${YELLOW}  Check pdflatex3.log for details${NC}"
        cd "$original_dir"
        return 1
    fi

    # Rename PDF
    if [ -f "main.pdf" ]; then
        mv main.pdf "${book_name}.pdf"
        echo -e "${GREEN}✓ Successfully compiled ${book_name}.pdf${NC}"

        # Show file size
        local size=$(du -h "${book_name}.pdf" | cut -f1)
        echo -e "${CYAN}  Size: ${size}${NC}"
    else
        echo -e "${RED}✗ PDF not generated${NC}"
        cd "$original_dir"
        return 1
    fi

    # Clean auxiliary files but keep PDF
    echo -e "${BLUE}Cleaning auxiliary files...${NC}"
    clean_aux_files "main"

    echo -e "${GREEN}✓ Done!${NC}"
    echo ""

    # Return to original directory
    cd "$original_dir"
}

compile_all_books() {
    echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  Compiling All Books                  ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
    echo ""

    local compiled=0
    local failed=0

    for book in "${BOOKS[@]}"; do
        if [ -d "$book" ]; then
            if compile_book "$book"; then
                ((compiled++))
            else
                ((failed++))
            fi
        else
            echo -e "${YELLOW}Skipping ${book} (directory not found)${NC}"
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
        # Compile all books (default if no arguments)
        compile_all_books
        exit 0
        ;;
    *)
        # Check if argument is a valid book directory
        if [ -d "$1" ] && [ -f "$1/main.tex" ]; then
            compile_book "$1"
        else
            echo -e "${RED}✗ Book not found: $1${NC}"
            echo ""
            echo -e "${YELLOW}Available books:${NC}"
            for book in "${BOOKS[@]}"; do
                if [ -d "$book" ]; then
                    echo -e "  ${GREEN}✓${NC} $book"
                else
                    echo -e "  ${RED}✗${NC} $book (not found)"
                fi
            done
            echo ""
            echo -e "${CYAN}Run './compile.sh --help' for usage information${NC}"
            exit 1
        fi
        ;;
esac
