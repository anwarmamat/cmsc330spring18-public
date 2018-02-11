OCAMLBUILD = ocamlbuild

SOURCES = basics.mli basics.ml testUtils.ml
PUBLIC_SOURCES = public.ml

PUBLIC_RESULT = public.native

OCAMLLDFLAGS = -g
PACKS = oUnit

all: $(PUBLIC_RESULT)

$(PUBLIC_RESULT): $(SOURCES) $(PUBLIC_SOURCES)
	$(OCAMLBUILD) $(PUBLIC_RESULT) -pkgs $(PACKS)

clean:
	rm -f *.cmi
	rm -f *.cmo
	$(OCAMLBUILD) -clean
