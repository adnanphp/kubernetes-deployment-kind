FROM python:3.10-slim

WORKDIR /app

# Install FastAPI and uvicorn
RUN pip install --no-cache-dir fastapi uvicorn

# Create app.py with proper formatting
RUN echo 'from fastapi import FastAPI' > app.py && \
    echo 'app = FastAPI()' >> app.py && \
    echo '@app.get("/health")' >> app.py && \
    echo 'def health():' >> app.py && \
    echo '    return {"status": "healthy"}' >> app.py && \
    echo '@app.get("/")' >> app.py && \
    echo 'def root():' >> app.py && \
    echo '    return {"message": "Kubernetes deployment working!"}' >> app.py

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
