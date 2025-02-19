.PHONY: all clean install

all: build

install:
	sudo apt-get update
	sudo apt-get install -y \
		texlive-full \
		pandoc \
		plantuml \
		python3-pip
	pip3 install diagrams

build:
	./build.sh

clean:
	rm -rf output/*