# PyTorch + CUDA + Jupyter + YOLO environment

# Use PyTorch 2.1.0 to match requirements.txt without needing to reinstall
FROM pytorch/pytorch:2.1.0-cuda11.8-cudnn8-runtime

# Build arguments for user permissions (Passed from build.bash)
ARG UID=1000
ARG GID=1000

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libsm6 \
    libxext6 \
    ffmpeg \
    wget \
    && rm -rf /var/lib/apt/lists/*
    
# Create a non-root user that matches host UID/GID
# This prevents files created in Docker from being locked as 'root' on PC
RUN groupadd -g $GID usergroup && \
	useradd -m -u $UID -g $GID -s /bin/bash user

# Set WORKDIR to /workspace to match the volume mount in rungpu.bash
WORKDIR /workspace

# Copy requirements
COPY requirements.txt .

# Install dependencies
# Allow pip to upgrade packages if necessary, but rely on the base image for Torch
RUN pip install --no-cache-dir \
    notebook==6.5.4 \
    jupyter_http_over_ws \
    -r requirements.txt

# Enable the Google Colab local runtime extension
RUN jupyter serverextension enable --py jupyter_http_over_ws

# Switch to the non-root user
USER user

# Default command
# Use 'bash -c' to ensure the jupyter command handles flags correctly
CMD ["jupyter", "notebook", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--allow-root", \
     "--NotebookApp.allow_remote_access=True", \
     "--NotebookApp.allow_origin='https://colab.research.google.com'", \
     "--NotebookApp.port_retries=0"]

