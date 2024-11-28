FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
COPY pyproject.toml poetry.lock ./


RUN pip install --no-cache-dir -r requirements.txt

ENV PATH="/usr/local/bin:${PATH}" 

RUN mkdir -p .file_versions && \
    chmod -R 777 .file_versions

COPY entrypoint.sh /app/entrypoint.sh 
RUN chmod +x /app/entrypoint.sh
    
COPY . .


EXPOSE 6789

ENTRYPOINT ["/app/entrypoint.sh"]