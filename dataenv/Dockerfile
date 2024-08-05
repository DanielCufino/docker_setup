FROM python:3.9-buster

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    libhdf5-dev \
    wget \
    curl \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy requirements.txt into the container
COPY requirements.txt .

# Install AWS CLI and Python dependencies
RUN pip install --upgrade pip setuptools wheel && \
    pip install awscli && \
    pip install -r requirements.txt

# Copy the rest of the application code
COPY . .

# Default command to keep the container running as an interactive shell
CMD ["tail", "-f", "/dev/null"]