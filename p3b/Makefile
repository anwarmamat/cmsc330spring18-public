# Compilation parameters
CC = ocamlc
PROGS = smallc public student
NO_TEST_CMO_DEPENDS = types.cmo parser.cmo lexer.cmo utils.cmo eval.cmo
FULL_CMO_DEPENDS = $(NO_TEST_CMO_DEPENDS) testUtils.cmo

all: $(PROGS)

clean: 
	@echo "Cleaning object files and executables"
	-@rm -f $(PROGS) smallc.cm[oi] studentTests.cm[oi] public.cm[oi] eval.cm[oi] types.cm[oi] utils.cm[oi] testUtils.cm[oi] oUnit*.log oUnit*.cache

public: $(FULL_CMO_DEPENDS) public.ml
	ocamlfind $(CC) -o public -linkpkg -package oUnit -g $(FULL_CMO_DEPENDS) public.ml

student: $(FULL_CMO_DEPENDS) studentTests.ml
	ocamlfind $(CC) -o student -linkpkg -package oUnit -g $(FULL_CMO_DEPENDS) studentTests.ml

smallc: $(NO_TEST_CMO_DEPENDS) smallc.cmo
	$(CC) -o smallc $(NO_TEST_CMO_DEPENDS) smallc.cmo

smallc.cmo: types.cmi parser.cmi lexer.cmi utils.cmi eval.cmi smallc.ml
	$(CC) -o smallc.cmo -c smallc.ml

eval.cmo: eval.cmi eval.ml types.cmi
	$(CC) -o eval.cmo -c eval.ml

eval.cmi: eval.mli types.cmi
	$(CC) -o eval.cmi -c eval.mli

testUtils.cmo testUtils.mli: eval.cmi utils.cmi testUtils.ml
	ocamlfind $(CC) -o testUtils -linkpkg -package oUnit -c testUtils.ml

utils.cmo utils.mli: types.cmi parser.cmi lexer.cmi utils.ml
	$(CC) -o utils -c utils.ml

types.cmo types.cmi: types.ml
	$(CC) -o types -c types.ml
