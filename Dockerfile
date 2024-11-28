# Use a base image with your desired Python version
FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy only requirements first to leverage Docker cache
COPY requirements.txt .
COPY pyproject.toml poetry.lock ./

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set environment variables and create necessary directories
ENV PATH="/usr/local/bin:${PATH}" \
    MAGE_AUTH_ENABLED=True

# Create directories with proper permissions
RUN mkdir -p .file_versions && \
    chmod -R 777 .file_versions

# Copy the rest of the application
COPY . .

# Expose the port that Mage AI uses
EXPOSE 6789

# Use environment variable for port if provided by Railway
CMD ["/usr/local/bin/mage", "start", ".", "--host", "0.0.0.0"]