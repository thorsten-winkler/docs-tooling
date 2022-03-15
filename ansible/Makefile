################################################################################
# Asciidoctor binary and options
################################################################################
ADOCBIN = asciidoctor
ADOCOPTS =

################################################################################
# - ADOC-CONFIG-META:
#   contains all meta attributes for the Asciidoctor html-files
# - ADOC-CONFIG-VARS:
#   contains all variable attributes used in all *.adoc files which include
#   this file
################################################################################
ADOC-CONFIG-META = .ansible-meta.adoc
ADOC-CONFIG-META-ALT1 = .adoc-meta.adoc
ADOC-CONFIG-META-ALT2 = meta
ADOC-CONFIG-VARS = .ansible-vars.adoc
ADOC-CONFIG-VARS-ALT1 = .adoc-vars.adoc
ADOC-CONFIG-VARS-ALT2 = vars

################################################################################
MASTER = ansible

ADOCSRC = ansible.adoc

all: clean_all config default

clean:
	@echo "################################################################################"
	@echo "# $(MASTER) - Delete all *.html-files:"
	@find . -name '*.html' -type f
	@find . -name '*.html' -type f -exec rm -r {} \;

clean_all: clean clean_config

clean_config:
	@echo "################################################################################"
	@echo "# $(MASTER) - Delete all symlinks:"
	@find . -type l -ls | awk '{print $$(NF-2) $$(NF-1) $$(NF)}'
	@find . -type l -exec rm -r {} \;

default:
	@echo "################################################################################"
	@echo "# $(MASTER) - $(ADOCBIN) renders all *.adoc-files:"
	$(ADOCBIN) $(ADOCSRC)

config: clean_config $(ADOC-CONFIG-META) $(ADOC-CONFIG-VARS) $(DOCS_DIR)
	@echo "################################################################################"
	@echo "# $(MASTER) - Configure, create symlinks, ..."
	@ln -s $(ADOC-CONFIG-META) $(ADOC-CONFIG-META-ALT1)
	@ln -s $(ADOC-CONFIG-META) $(ADOC-CONFIG-META-ALT2)
	@ln -s $(ADOC-CONFIG-VARS) $(ADOC-CONFIG-VARS-ALT1)
	@ln -s $(ADOC-CONFIG-VARS) $(ADOC-CONFIG-VARS-ALT2)

.DEFAULT_GOAL := all
