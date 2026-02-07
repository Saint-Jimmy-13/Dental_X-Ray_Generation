# PyTorch + CUDA + Jupyter + YOLO environment

FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime

# Build arguments for user permissions
ARG UID=1000
ARG GID=1000

# Install system dependencies (including headless OpenCV)
RUN apt-get update && apt-get install -y \
    libsm6 \
    libxext6 \
    ffmpeg \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Create workspace directory
WORKDIR src/

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir \
    notebook==7.0.6 \
    jupyter_http_over_ws \
    -r requirements.txt

# Configure Jupyter for Colab access
RUN mkdir -p ~/.jupyter && \
    echo "c.NotebookApp.allow_origin = 'https://colab.research.google.com'" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.allow_remote_access = True" >> ~/.jupyter/jupyter_notebook_config.py
    
# Copy project files
COPY . .

# Default command: Launch Jupyter
CMD ["jupyter", "notebook", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--allow-root", \
     "--NotebookApp.allow_remote_access=True", \
     "--NotebookApp.allow_origin=https://colab.research.google.com"]

