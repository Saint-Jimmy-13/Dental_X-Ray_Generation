FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

# System dependencies
RUN apt-get update && apt-get install -y \
	git wget unzip ffmpeg libsm6 libxext6 \
	&& rm -rf /var/lib/apt/lists/*

# Create workspace
WORKDIR /workspace

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Set Jupyter defaults
EXPOSE 8888
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser"]

