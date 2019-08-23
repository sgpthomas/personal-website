function loop() {
  find site templates soupault.conf | entr -d make build
  rm -r build/*
  loop
}

loop
