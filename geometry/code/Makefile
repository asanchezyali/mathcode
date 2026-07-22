CC      = gcc
RUSTC   = rustc
PYTHON  = python3
CFLAGS  = -O2 -Wall -lm
RFLAGS  = -O

SOURCES_C    = $(wildcard *.c)
SOURCES_RS   = $(wildcard *.rs)
SOURCES_PY   = $(wildcard *.py)
BINS_C       = $(SOURCES_C:.c=_c)
BINS_RS      = $(SOURCES_RS:.rs=_rs)

.PHONY: all clean run run-c run-rust run-python

all: $(BINS_C) $(BINS_RS)

%_c: %.c
	$(CC) $(CFLAGS) -o $@ $<

%_rs: %.rs
	$(RUSTC) $(RFLAGS) -o $@ $<

run: run-c run-rust run-python

run-c: $(BINS_C)
	@for bin in $(BINS_C); do \
		echo "=== $$bin ==="; \
		./$$bin; \
		echo; \
	done

run-rust: $(BINS_RS)
	@for bin in $(BINS_RS); do \
		echo "=== $$bin ==="; \
		./$$bin; \
		echo; \
	done

run-python:
	@for src in $(SOURCES_PY); do \
		echo "=== $$src ==="; \
		$(PYTHON) $$src; \
		echo; \
	done

clean:
	rm -f $(BINS_C) $(BINS_RS)
