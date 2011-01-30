POFILES := $(wildcard *.po)
MOFILES := $(patsubst %.po, %.mo, $(POFILES))

all: $(MOFILES)

%.mo: %.po
	msgfmt -c --statistics $< -o $@

clean:
	rm -f *.mo

.PHONY: all clean
