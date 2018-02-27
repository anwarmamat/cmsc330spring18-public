OCAMLBUILD = ocamlbuild

SOURCES = data.mli data.ml higher.mli higher.ml testUtils.ml
PUBLIC_SOURCES = public.ml

PUBLIC_RESULT = public.native

OCAMLLDFLAGS = -g
PACKS = oUnit

all: $(PUBLIC_RESULT) $(RELEASE_RESULT)

$(PUBLIC_RESULT): $(SOURCES) $(PUBLIC_SOURCES)
	$(OCAMLBUILD) $(PUBLIC_RESULT) -pkgs $(PACKS)

clean:
	rm -f *.byte
	rm -f *.native
	rm -f *.cmi
	rm -f *.cmo
	$(OCAMLBUILD) -clean
