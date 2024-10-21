# FSE project group 5

This is a repo for Foundations of Software Engineering project.
Chatbot, trained on "Harry Potter" movies.

- Build an image with ollama:
```bash
docker build -t chat .
``` 
- Run built image with ollama:
```bash
docker run -d --name chat chat
``` 
- Run our Harry Potter model:
```bash
docker exec -it chat ollama run hf.co/makriot/model
```
