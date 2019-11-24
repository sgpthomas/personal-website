.PHONY: build open clean watch server

build:
	soupault

deploy:
	./deploy.sh

open: build
	xdg-open build/index.html

watch:
	while true; do find site/ templates/ plugins/ markdown-settings/ soupault.conf | entr -cd make build; test $? -gt 128 && break; done

server: build
	cd build; python3 -m http.server
