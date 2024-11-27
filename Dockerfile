# Use a base image with your desired Python version
FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the entire project first (including your existing Mage structure)
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
ENV PATH="/usr/local/bin:${PATH}"

RUN mkdir -p .file_versions && \
    chmod -R 777 .file_versions

# Set environment variables
# ENV ENVIRONMENT=dev
# ENV STREAMS_CHARTS_CLIENT_ID=${STREAMS_CHARTS_CLIENT_ID}
# ENV STREAMS_CHARTS_TOKEN=${STREAMS_CHARTS_TOKEN}
# ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
# ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
# ENV AWS_REGION=${AWS_REGION}

# Expose the port that Mage AI uses
EXPOSE 6789

# Start the Mage AI server using your existing project
CMD ["/usr/local/bin/mage", "start", ".", "--host", "0.0.0.0"]