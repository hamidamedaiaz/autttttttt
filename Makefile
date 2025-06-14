# Liste des fichiers .flo sans extension
INPUT := $(basename $(notdir $(wildcard input/*.flo)))
OUTPUT_DIR := output

# Cible par défaut
all: $(addprefix $(OUTPUT_DIR)/,$(INPUT))

# Règle de compilation : .flo → .S → exécutable
$(OUTPUT_DIR)/%: input/%.flo
	@echo "Compilation: $<"
	@mkdir -p $(OUTPUT_DIR)
	@if python3 generation_code.py -arm $< > $(OUTPUT_DIR)/$*.S ; then \
		arm-linux-gnueabi-gcc $(OUTPUT_DIR)/$*.S -static -o $@ ; \
	else \
		echo "Erreur: La génération du code pour $< a échoué" ; \
	fi

# Nettoyer les fichiers générés
clean:
	rm -f $(OUTPUT_DIR)/*.S $(OUTPUT_DIR)/*

# Exécuter un fichier compilé avec QEMU (ex : make run file=arith_1)
run:
	@if [ -z "$(file)" ]; then \
		echo "Usage : make run file=<nom_du_fichier_sans_extension>" ; \
	else \
		qemu-arm $(OUTPUT_DIR)/$(file) ; \
	fi

# Pour forcer la recompilation
rebuild: clean all
