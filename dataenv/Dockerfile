# Use multi-stage builds to reduce the image size
FROM python:3.9-buster AS builder

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    libhdf5-dev \
    wget \
    curl \
    git \
    unzip

# Set the working directory
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel && \
    pip install awscli && \
    pip install -r requirements.txt

# Final stage
FROM python:3.9-buster

# Copy installed dependencies from the builder stage
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin/aws /usr/local/bin/aws

# Set the working directory
WORKDIR /app

# Copy the rest of the application code
COPY . .

# Default command to keep the container running as an interactive shell
CMD ["tail", "-f", "/dev/null"]
