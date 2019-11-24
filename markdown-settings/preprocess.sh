DIR=markdown-settings

pandoc $1 \
       -st HTML \
       --highlight-style $DIR/blog.theme \
       --template $DIR/markdown.template \
       --syntax-definition $DIR/racket.xml \
       --mathml
