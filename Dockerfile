FROM ubuntu:latest

RUN apt update && apt upgrade -y

RUN apt-get update && apt-get install -y make git curl vim nano

WORKDIR /app


COPY ollama.sh Makefile .

RUN make prereqs

ENTRYPOINT ["ollama"]
CMD ["serve"]
