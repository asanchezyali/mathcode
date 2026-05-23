BOOKS = deep_learning machine_learning llms inferencial_statistics \
        geometry math_fundamentals numerical_methods

.PHONY: all books code clean clean-books clean-code help \
        $(BOOKS) $(addsuffix -code,$(BOOKS))

# --- Default ---
all: books code

# --- Books ---
books: $(BOOKS)

$(BOOKS):
	@./compile.sh $@

# --- Code (per-book) ---
code:
	@for book in $(BOOKS); do \
		if [ -f $$book/code/Makefile ]; then \
			echo "=== Building code: $$book ==="; \
			$(MAKE) -C $$book/code all; \
		fi; \
	done

%-code:
	@$(MAKE) -C $*/code all

%-run:
	@$(MAKE) -C $*/code run

# --- Clean ---
clean: clean-books clean-code

clean-books:
	@./compile.sh --clean

clean-code:
	@for book in $(BOOKS); do \
		if [ -f $$book/code/Makefile ]; then \
			$(MAKE) -C $$book/code clean; \
		fi; \
	done

# --- Help ---
help:
	@echo "Usage:"
	@echo "  make                       Build all books and code"
	@echo "  make books                 Compile all books (LaTeX)"
	@echo "  make code                  Build all code (C, Rust)"
	@echo ""
	@echo "  make <book>                Compile a single book, e.g.:"
	@echo "    make numerical_methods"
	@echo "    make math_fundamentals"
	@echo ""
	@echo "  make <book>-code           Build code for a book, e.g.:"
	@echo "    make numerical_methods-code"
	@echo ""
	@echo "  make <book>-run            Build and run code for a book, e.g.:"
	@echo "    make numerical_methods-run"
	@echo ""
	@echo "  make clean                 Clean everything"
	@echo "  make clean-books           Clean LaTeX aux files"
	@echo "  make clean-code            Clean compiled binaries"
	@echo ""
	@echo "Available books: $(BOOKS)"
