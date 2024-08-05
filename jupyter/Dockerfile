FROM jupyter/scipy-notebook:latest

# Install additional Python packages
COPY requirements.txt /tmp/
RUN pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt