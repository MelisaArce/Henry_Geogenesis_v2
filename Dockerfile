# app/Dockerfile

FROM python:3.9-slim

WORKDIR /prueba_docker

RUN pip install --upgrade pip

RUN apt-get update && apt-get install -y \
    build-essential \
    libcurl4-openssl-dev \
    libpq-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip3 install -r requirements.txt
RUN rm requirements.txt

COPY . .

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "streamlit/main.py", "--server.port=8501", "--server.address=0.0.0.0"]   