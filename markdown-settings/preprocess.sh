DIR=markdown-settings

pandoc $1 \
       -st HTML \
       --template=$DIR/markdown.template \
       --syntax-definition=$DIR/racket.xml \
       --mathml
