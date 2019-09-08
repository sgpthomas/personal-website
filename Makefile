.PHONY: build open clean watch server

build:
	soupault

open: build
	xdg-open build/index.html

clean:
	rm -r build

watch:
	while true; do find site/ templates/ plugins/ soupault.conf | entr -cd make build; test $? -gt 128 && break; done

server: build
	cd build; python3 -m http.server
