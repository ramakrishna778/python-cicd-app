# ==============================
# Stage 1 - Builder
# ==============================
FROM python:3.11-slim AS builder

# Prevent Python cache files
ENV PYTHONDONTWRITEBYTECODE=1

# Prevent buffered logs
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install dependencies first
COPY requirements.txt .

# Install dependencies into custom folder
RUN pip install --no-cache-dir \
    --prefix=/install \
    -r requirements.txt

# ==============================
# Stage 2 - Runtime
# ==============================
FROM python:3.11-alpine

# Python runtime optimizations
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Copy installed packages only
COPY --from=builder /install /usr/local

# Copy application code
COPY app.py .

# Create non-root user
RUN adduser -D appuser

USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
