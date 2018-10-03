BYTECC = ocamlc
NATIVECC = ocamlopt
CMO_DEPENDS = sets.cmo
PACKS=str

all: sets_pkg

sets_pkg: sets.cma META
	ocamlfind install sets META sets.cmi sets.cma

sets.cma: $(CMO_DEPENDS)
	ocamlfind $(BYTECC) -a -o $@ -linkpkg -package $(PACKS) -g $(CMO_DEPENDS)

# Need to also include the cmxa for running tests... not sure how to build those yet
