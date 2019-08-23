.PHONY: build open clean watch server

build:
	soupault

open: build
	xdg-open build/index.html

clean:
	rm -r build

watch:
	./watch.sh

server: build
	cd build; python3 -m http.server
