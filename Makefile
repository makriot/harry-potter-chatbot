# Makefile

# Default target
.PHONY: prereqs
prereqs:
	@echo "Installing packages & dependencies"
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
	@echo "Dependencies installed successfully."

	@echo "Installing ollama for LLM inference"
	@curl -fsSL https://ollama.com/install.sh | sh
	@echo "Ollama installed!"

	@echo "Compiling postprocessing and creating a binary file"
	git clone https://github.com/GreycLab/CImg.git
	apt-get install -y libx11-dev
	apt-get install -y libpng-dev
	@echo "Postprocessing compiled and a binary file was created"

.PHONY: build
build:
	./entrypoint.sh
	g++ -std=c++17 -I./CImg/ postprocessing.cpp -o postprocessing -lX11 -lpthread -lpng

.PHONY: processing
processing:
	python3 processing.py

.PHONY: postprocessing
postprocessing:
	./postprocessing

