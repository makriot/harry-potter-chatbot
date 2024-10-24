import os
import requests
import json

input_folder = './input'
output_folder = './output_raw'
model_endpoint = 'http://localhost:11434/api/generate'
custom_model = 'hf.co/makriot/model:latest'  # Replace with your actual model path

# Ensure output folder exists
os.makedirs(output_folder, exist_ok=True)

# Process each OCR output file
for filename in os.listdir(input_folder):
    if filename.endswith('.txt'):
        input_path = os.path.join(input_folder, filename)
        output_path = os.path.join(output_folder, f"response_{filename}")

        # Read OCR text
        with open(input_path, 'r') as f:
            ocr_text = f.read()

        # Prepare the request to Ollama
        response = requests.post(model_endpoint, json={
            'model': custom_model,
            'prompt': ocr_text,
            'stream': True  # Request streaming response
        }, stream=True)

        full_response = ""

        # Process the streaming response
        for line in response.iter_lines():
            if line:
                json_response = json.loads(line)
                if 'response' in json_response:
                    full_response += json_response['response']
                    print(json_response['response'], end='', flush=True)  # Print response in real-time
                if json_response.get('done', False):
                    break

        # Write the full response to a corresponding output file
        with open(output_path, 'w') as output_file:
            output_file.write(full_response)

        print(f"\nResponse for {filename} written to {output_path}")

print('All responses have been written to separate files in', output_folder)
