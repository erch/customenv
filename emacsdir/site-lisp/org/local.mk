# Name of your emacs binary
EMACS="\"${EMACS_HOME}\""/bin/:q
emacs.exe
# Where local software is found
prefix="home/ech/customenv/emacsdir"

# Where local lisp files go
lispdir   = $(prefix)/share/emacs/site-lisp

# Where data files go
# $(datadir) contains auxiliary files for use with ODT exporter.
# See comments under DATAFILES.
datadir = $(prefix)/etc

# Where info files go
infodir = $(prefix)/info

