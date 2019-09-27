.PHONY: build open clean watch server

build:
	soupault

deploy:
	cd build; git add .; git commit -m "deploy"; git push

open: build
	xdg-open build/index.html

watch:
	while true; do find site/ templates/ plugins/ soupault.conf | entr -cd make build; test $? -gt 128 && break; done

server: build
	cd build; python3 -m http.server
