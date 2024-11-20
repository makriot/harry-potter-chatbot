# FSE project group 5

This is a repo for Foundations of Software Engineering for AI project.
Chatbot, trained on "Harry Potter" movies.

To chat with model, you should put .txt or .wav files in 16kH into `input_raw` directory, then run a pipeline. Results with chatbot's answers will be in `output` directory.
## Quick Start on Local Machine
- Clone repository
- Make sure make is installed
```bash
apt-get update && apt-get install -y make
```
- Installing all required packages and libraries, Compiling and Running the code. 
```bash
make
```

## Quick Start with Docker
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
docker attach harry-potter-chatbot-my_service-1
```

- Now we need to build our binaries and install our model:
```bash
make build
```

- How can we run pipeline:
```bash
make run
```

The results inside of a Docker Container are synchronised with your local machine, so you can easily access it!
If you face troubles, you can see an [example](https://docs.google.com/document/d/1zbvqpISPHD3WelM_D59OBPc21YzwXVGRkx0QPJeXwwk/edit?usp=sharing) of running pipeline.

LLama 3.2 was trained with this code: [link](https://www.kaggle.com/code/tokhchukovdanil/harry-potter-chatbot-llama-3-2-1b).


<!-- - Now we need to build our binaries and install our model:
```bash
make build
```

- To Preprocess our data:
```bash
make preprocessing
```

- To Process our data:
```bash
make processing
```

- To Postprocess our data:
```bash
make postprocessing
```

The results inside of a Docker Container are synchronised with your local machine, so you can easily access it! -->
