SRCFILES := $(wildcard *.mangled-po)
MOFILES := $(patsubst %.mangled-po, %.mo, $(SRCFILES))

all: $(MOFILES) gtk20.mo

gtk20.mo: simple/gtk20.po
	msgfmt -c $< -o $@

%.mo: %.po
	msgfmt -c $< -o $@

%.t-po: %.mangled-po
	scripts/demangle.pl < $< > $@

%.o-po: %.mangled-po
	scripts/demangle_orig.pl < $< > $@

%.po: %.t-po %.o-po
	msgcat --use-first $^ > $@
clean:
	rm -f *.mo *.t-po *.o-po *.po

.PHONY: all clean
