FROM ubuntu:latest

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt upgrade -y && apt-get update && apt-get install -y make apt-utils sudo

WORKDIR /app

COPY Makefile preprocessing.sh postprocessing.cpp processing.py entrypoint.sh ./

RUN chmod +x entrypoint.sh && chmod +x preprocessing.sh 

RUN make prereqs