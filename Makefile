SRCFILES := $(wildcard *.m.po)
MOFILES := $(patsubst %.m.po, %.mo, $(SRCFILES))

all: $(MOFILES) gtk20.mo

gtk20.mo: simple/gtk20.po
	msgfmt -c $< -o $@

%.mo: %.f.po
	msgfmt -c $< -o $@

%.t-po: %.m.po
	scripts/demangle.pl < $< > $@

%.o-po: %.m.po
	scripts/demangle_orig.pl < $< > $@

%.f.po: %.t-po %.o-po
	msgcat --use-first $^ > $@
clean:
	rm -f *.mo *.t-po *.o-po *.f.po

check:
	for file in $(SRCFILES); do echo $$file; msgfmt -c --statistics -o /dev/null $$file; done

.PHONY: all clean check
