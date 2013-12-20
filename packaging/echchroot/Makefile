SHELL=/bin/bash

HOSTAPT_DIR=/var/apt-repo
ROOT_DIR=$(CURDIR)
PCKG_ROOT=build
DIST_ROOT=build


SRC_ROOT=src
SRC_CONTROL_DIR = $(SRC_ROOT)/unix
SRC_CONTROL_FILES = $(shell find $(SRC_CONTROL_DIR) -name .svn -prune -o -type f -print)

version = $(strip $(shell grep Version $(SRC_CONTROL_DIR)/DEBIAN/control | cut -d ':' -f2))
PKG_NAME = $(strip $(shell grep Package $(SRC_CONTROL_DIR)/DEBIAN/control | cut -d ':' -f2))
DIST_PCKG = $(DIST_ROOT)/$(PKG_NAME)_$(version)_all.deb

PCKG_CONTROL_DIR=$(PCKG_ROOT)/unix
PCKG_CONTROL_FILES=$(subst  $(SRC_CONTROL_DIR),$(PCKG_CONTROL_DIR), $(filter-out %.tmpl,$(SRC_CONTROL_FILES))) \
	$(patsubst  %.tmpl,%,$(filter %.tmpl,$(SRC_CONTROL_FILES)))
M4_INCLUDE_FILE=$(PCKG_ROOT)/m4env

all: $(M4_INCLUDE_FILE) $(DIST_PCKG)

$(DIST_PCKG): $(PCKG_CONTROL_FILES) Makefile | $(PCKG_CONTROL_DIR)
	fakeroot -- dpkg -b $(PCKG_CONTROL_DIR) $(DIST_PCKG)

$(PCKG_CONTROL_DIR):
	-mkdir -p $(PCKG_CONTROL_DIR)

install: all
	ncftpput -u reporw -p $(BOMAPT_PSWD) apt.bestofmedia.com incoming $(DIST_PCKG)

localdist:all
	sudo  bash -c "cp $(DIST_PCKG) $(HOSTAPT_DIR) && cd $(HOSTAPT_DIR)  && dpkg-scanpackages . /dev/null > Packages.gz"

$(M4_INCLUDE_FILE):
	echo "define(\`__USER__',\`$(USER)')" > $(M4_INCLUDE_FILE)

clean:
	cd $(CURDIR) && cd $(PCKG_ROOT) && rm -rf *
	cd $(CURDIR)  && cd $(DIST_ROOT) && rm -rf *

# implicit rule to copy files
$(PCKG_CONTROL_DIR)/% : $(SRC_CONTROL_DIR)/%
	cd $(SRC_CONTROL_DIR);\
	mkdir -p $(ROOT_DIR)/$(PCKG_CONTROL_DIR)/$(dir $(subst  $(SRC_CONTROL_DIR),.,$^));\
	cp  $(subst  $(SRC_CONTROL_DIR),.,$^) $(ROOT_DIR)/$(PCKG_CONTROL_DIR)/$(dir $(subst  $(SRC_CONTROL_DIR),.,$^))

# implicit rule to apply m4 to a template file
%:%.tmpl
	m4 -I $(dir $(M4_INCLUDE_FILE)) $^ > $@

debug:
	$(warning sources:)
	$(foreach v,$(SRC_CONTROL_FILES),$(warning s: $v))
	$(warning package:)
	$(foreach v,$(PCKG_CONTROL_FILES),$(warning p: $v))
