################################################################################
# Asciidoctor binary and options
################################################################################
ADOCBIN = asciidoctor
ADOCOPTS =

################################################################################
CURRENT_DIR_NAME=$(shell basename $(PWD))
MASTER = tooling

################################################################################
# - ADOC-CONFIG-META:
#   contains all meta attributes for the Asciidoctor html-files
# - ADOC-CONFIG-VARS:
#   contains all variable attributes used in all *.adoc files which include
#   this file
################################################################################
ADOC-CONFIG-META = .$(MASTER)-meta.adoc
ADOC-CONFIG-META-ALT1 = .adoc-meta.adoc
ADOC-CONFIG-META-ALT2 = meta
ADOC-CONFIG-VARS = .$(MASTER)-vars.adoc
ADOC-CONFIG-VARS-ALT1 = .adoc-vars.adoc
ADOC-CONFIG-VARS-ALT2 = vars

################################################################################

DOCS_DIR = ../../boxsync/Documents/$(CURRENT_DIR_NAME)/docs_n_books
DOCS_DIR_TARGET = ./docs_n_books

GH-PAGES-DIR = ./docs
SCRIPTS-DIR = ./scripts
CONFIGS-DIR = ./configs

SUBDIR-ANSIBLE = ansible
SUBDIR-GIT = git
SUBDIRS = $(SUBDIR-ANSIBLE) \
          $(SUBDIR-GIT)
TEMP-FILE = temp.adoc

################################################################################
ADOCSRC = $(MASTER).adoc \
		  $(TEMP-FILE)

################################################################################
all: clean_all config subs default index

clean:
	@echo "################################################################################"
	@echo "# $(MASTER) - Delete all *.html-files:"
	@find . -name '*.html' -type f
	@find . -name '*.html' -type f ! -name docs/index.html -exec rm -r {} \;

clean_all: clean clean_config

clean_config:
	@echo "################################################################################"
	@echo "# $(MASTER) - Delete all symlinks"
	@find . -type l -ls | awk '{print $$(NF-2) $$(NF-1) $$(NF)}'
	@find . -type l -exec rm -r {} \;

config: clean_config $(ADOC-CONFIG-META) $(ADOC-CONFIG-VARS)  #$(DOCS_DIR)
	@echo "################################################################################"
	@echo "# $(MASTER) - Configure, create symlinks, ..."
	@ln -s $(ADOC-CONFIG-META) $(ADOC-CONFIG-META-ALT1)
	@ln -s $(ADOC-CONFIG-META) $(ADOC-CONFIG-META-ALT2)
	@ln -s $(ADOC-CONFIG-VARS) $(ADOC-CONFIG-VARS-ALT1)
	@ln -s $(ADOC-CONFIG-VARS) $(ADOC-CONFIG-VARS-ALT2)

	#@ln -s $(DOCS_DIR) $(DOCS_DIR_TARGET)

	@mkdir -p $(SCRIPTS-DIR)
	@mkdir -p $(CONFIGS-DIR)
	@ln -s ../$(SUBDIR-ANSIBLE)/scripts $(SCRIPTS-DIR)/$(SUBDIR-ANSIBLE)
	@ln -s ../$(SUBDIR-ANSIBLE)/configs $(CONFIGS-DIR)/$(SUBDIR-ANSIBLE)
	@ln -s ../$(SUBDIR-GIT)/scripts $(SCRIPTS-DIR)/$(SUBDIR-GIT)
	@ln -s ../$(SUBDIR-GIT)/configs $(CONFIGS-DIR)/$(SUBDIR-GIT)

default:
	@echo "################################################################################"
	@echo "# $(MASTER) - $(ADOCBIN) renders all *.adoc-files:"
	$(ADOCBIN) $(ADOCSRC)

index: $(MASTER).html
	@echo "################################################################################"
	@echo "# $(MASTER) - Clone index.html file"
	@cp $(MASTER).html $(GH-PAGES-DIR)/index.html

subs:
	@echo "################################################################################"
	@echo "# $(MASTER) - $(ADOCBIN) renders all *.adoc-files in all (sub-)directories:"
	@$(MAKE) -C $(SUBDIR-ANSIBLE)
	@$(MAKE) -C $(SUBDIR-GIT)

.DEFAULT_GOAL := all
