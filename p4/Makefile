CC = ocamlc
CMO_DEPENDS = sets.cmo nfa.cmo regexp.cmo testUtils.cmo
PACKS=oUnit,str

PUBLIC_RESULT = public.native
VISUALIZE_RESULT = viz.native
PROGS=$(PUBLIC_RESULT) $(VISUALIZE_RESULT)

all: public viz

public: $(PUBLIC_RESULT)
viz: $(VISUALIZE_RESULT)

$(PUBLIC_RESULT): $(CMO_DEPENDS) public.ml
	ocamlfind $(CC) -o $@ -linkpkg -package $(PACKS) -g $(CMO_DEPENDS) public.ml

$(VISUALIZE_RESULT): $(CMO_DEPENDS) viz.ml
	ocamlfind $(CC) -o $@ -linkpkg -package $(PACKS) -g $(CMO_DEPENDS) viz.ml

nfa.cmo: nfa.ml nfa.cmi
	$(CC) -o $@ -c nfa.ml

nfa.cmi: nfa.mli
	$(CC) -o $@ -c nfa.mli

regexp.cmo: regexp.ml regexp.cmi nfa.cmo nfa.cmi
	$(CC) -o $@ -c regexp.ml

regexp.cmi: regexp.mli nfa.cmo nfa.cmi
	$(CC) -o $@ -c regexp.mli

testUtils.cmo testUtils.mli: nfa.cmo regexp.cmo testUtils.ml
	ocamlfind $(CC) -o testUtils -linkpkg -package oUnit -c testUtils.ml

clean:
	@echo "Cleaning object files and executables"
	-@rm -f $(PROGS) public.cm[oi] viz.cm[oi] nfa.cm[oi] regexp.cm[oi] testUtils.cm[oi] oUnit*.log oUnit*.cache
