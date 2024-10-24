# Makefile

.PHONY: all prereqs build preprocessing postprocessing

all: prereqs build preprocessing processing postprocessing

run: preprocessing processing postprocessing

# Default target
prereqs:
	@echo "Installing common packages & dependencies"
	apt-get install -y curl 
	apt-get install -y vim 
	apt-get install -y nano
	apt-get install -y libpng-dev libjpeg-dev libtiff-dev zlib1g-dev
	apt-get install -y gcc g++
	apt-get install -y autoconf automake libtool checkinstall
	apt-get install -y libleptonica-dev
	apt-get install -y git
	apt-get install -y cmake
	apt-get install -y systemctl
	apt-get install -y pkg-config
	apt-get install -y wget
	apt-get install -y pip
	apt-get install -y python3-requests
	apt-get install -y git wget curl make build-essential
	@echo "Common dependencies installed successfully."

	@echo "Installing preprocessing dependencies"
	git clone https://github.com/ggerganov/whisper.cpp.git
	@echo "Completed preprocessing dependencies installation"

	@echo "Installing ollama for LLM inference"
	@curl -fsSL https://ollama.com/install.sh | sh
	@echo "Ollama installed!"

	@echo "Installing postprocessing dependencies"
	git clone https://github.com/GreycLab/CImg.git
	apt-get install -y libx11-dev
	apt-get install -y libpng-dev
	@echo "Completed postprocessing dependencies installation"

build:
	@echo "Compiling preprocessing and creating a binary file"
	cd whisper.cpp && sh ./models/download-ggml-model.sh base.en
	cd whisper.cpp && make -j
	@echo "Compiled preprocessing and created a binary file"

	@echo "Compiling processing and creating a binary file"
	./entrypoint.sh
	@echo "Compiled processing and created a binary file"

	@echo "Compiling postprocessing and creating a binary file"
	g++ -std=c++17 -I./CImg/ postprocessing.cpp -o postprocessing -lX11 -lpthread -lpng
	@echo "Compiled postrocessing and created a binary file"

preprocessing:
	./preprocessing.sh

processing:
	python3 processing.py

postprocessing:
	./postprocessing
