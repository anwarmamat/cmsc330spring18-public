OCAMLBUILD = ocamlbuild

SOURCES = lexer.ml parser.ml utils.ml smallCTypes.ml
PUBLIC_SOURCES = public.ml

INTERFACE_RESULT = interface.byte
PUBLIC_RESULT = public.byte

OCAMLLDFLAGS = -g
PACKS = oUnit,str

all: $(PUBLIC_RESULT) $(INTERFACE_RESULT)

clean:
	rm -f *.byte
	rm -f *.native
	rm -f *.cmi
	rm -f *.cmo
	$(OCAMLBUILD) -clean

interface: $(INTERFACE_RESULT)

public: $(PUBLIC_RESULT)

$(INTERFACE_RESULT): $(SOURCES) interface.ml
	$(OCAMLBUILD) $(INTERFACE_RESULT) -pkgs $(PACKS)

$(PUBLIC_RESULT): $(SOURCES) $(PUBLIC_SOURCES)
	$(OCAMLBUILD) $(PUBLIC_RESULT) -pkgs $(PACKS)
