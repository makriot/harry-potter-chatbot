#!/bin/bash

systemctl daemon-reload 
systemctl enable ollama 
systemctl restart ollama 
ollama pull hf.co/makriot/model


