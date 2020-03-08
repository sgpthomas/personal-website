.PHONY: build open clean watch server

SOUPAULT=./soupault

build:
	$(SOUPAULT)

clean:
	rm -rf build

open: build
	xdg-open build/index.html

watch:
	while true; do find scripts/ site/ templates/ plugins/ markdown-settings/ soupault.conf | entr -cd make build; test $? -gt 128 && break; done

server: build
	cd build; python3 -m http.server

update:
	git clone git@github.com:dmbaturin/soupault.git soupault_build
	cd soupault_build; dune build
	cp soupault_build/_build/default/src/soupault.exe soupault
	rm -rf soupault_build

