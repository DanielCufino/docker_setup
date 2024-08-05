FROM python:3.9-buster

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    libhdf5-dev \
    wget \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Python build dependencies
RUN pip install --upgrade pip setuptools wheel

# Copy requirements.txt into the container
COPY requirements.txt /app/requirements.txt

# Install Python packages
RUN pip install -r /app/requirements.txt

# Create a working directory
WORKDIR /app

# Copy your project code into the container
COPY . /app

# Default command to keep the container running as an interactive shell
CMD ["tail", "-f", "/dev/null"]