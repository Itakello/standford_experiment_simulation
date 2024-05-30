# Use the NVIDIA PyTorch image as the base image
FROM nvcr.io/nvidia/pytorch:24.05-py3

# Update the OS and install any necessary dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --upgrade pip

# Install the ollama external service
RUN curl https://ollama.ai/install.sh | sh

# Copy the requirements.txt file and install Python dependencies
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Copy the main.py file and project files into the container
COPY main.py /app/
COPY src /app/src

# Set the working directory
WORKDIR /app

# Start ollama service in the background and suppress its output
ENTRYPOINT ["bash", "-c", "ollama serve > /dev/null 2>&1 & exec bash"]

# Use an infinite loop to keep the container alive
CMD ["tail", "-f", "/dev/null"]
