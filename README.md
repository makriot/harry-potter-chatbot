# FSE project group 5

This is a repo for Foundations of Software Engineering project.
Chatbot, trained on "Harry Potter" movies.

- Build an image with ollama:
```bash
docker build -t chat .
``` 
- Run built image:
```bash
docker compose up -d
``` 
- Enter inside of a container:
```bash
docker exec harry-potter-chatbot-my_service-1 bash
```

- Now we need to build our binaries and install our model:
```bash
make build
```

- To Process our data:
```bash
make processing
```

- To Postprocess our data:
```bash
make postprocessing
```

The results inside of a Docker Container are synchronised with your local machine, so you can easily access it!