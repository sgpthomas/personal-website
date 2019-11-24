rm -r build
make build
git clone git@github.com:sgpthomas/sgpthomas.github.io.git deploy
cd deploy
rm -r *
cp -r ../build/* .
git add .
git commit
git push origin master
cd ..
rm -r deploy
