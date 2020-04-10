FROM fedora:latest

RUN dnf -y install pandoc python3-pip make
RUN pip3 install pystache
WORKDIR /home/website

COPY . .

ENTRYPOINT ["make"]
