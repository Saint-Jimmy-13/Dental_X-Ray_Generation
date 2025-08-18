# Base image: PyTorch + Jupyter + CUDA
FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime

# Create necessary folders
RUN mkdir -p /workspace/src

# Set working directory
WORKDIR /workspace/src

# Copy everything into /workspace/src (excluding .dockerignore items)
COPY . .

# Install Python packages
RUN pip install --no-cache-dir \
	notebook==6.5.4 \
	jupyter_http_over_ws \
	-r requirements.txt
	

# Enable Jupyter over WebSockets
# Manually configure WebSocket permissions for Colab
RUN mkdir -p ~/.jupyter && \
    echo "c.NotebookApp.allow_origin = 'https://colab.research.google.com'" >> ~/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.allow_remote_access = True" >> ~/.jupyter/jupyter_notebook_config.py

# Set environment variables
ENV PYTHONPATH=/workspace/src

# Default command for launching Jupyter in Colab
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", \
	"--NotebookApp.allow_remote_access=True", \
	"--allow-root", \
    "--NotebookApp.allow_origin='https://colab.research.google.com'", \
    "--port=8888", "--NotebookApp.port_retries=0"]

