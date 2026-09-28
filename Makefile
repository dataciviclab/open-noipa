TOOLKIT = toolkit

DATASETS := $(shell find datasets -name dataset.yml 2>/dev/null | sort)

.PHONY: check run run-all clean registry help

check:
	@for f in $(DATASETS); do \
		echo "→ $$f"; \
		$(TOOLKIT) run preflight --config "$$f" > /dev/null 2>&1 || exit 1; \
	done
	@echo "✅ All configs valid"

run:
	@for f in $(DATASETS); do \
		echo "=== $$f ==="; \
		$(TOOLKIT) run --config "$$f" || exit 1; \
	done

run-all: run

registry:
	$(TOOLKIT) registry build --prefix open-noipa

registry-write:
	$(TOOLKIT) registry build --prefix open-noipa --write

help:
	@grep -E '^[a-zA-Z_-]+:' Makefile | sort
