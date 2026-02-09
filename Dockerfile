# Use official Python 3.11 slim image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y build-essential libpq-dev curl && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements first (for caching)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project
COPY . .

# Expose port for Cloud Run
EXPOSE 8080

# Set environment variable for Django
ENV DJANGO_SETTINGS_MODULE=myproject.settings

# Run Django app using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "myproject.wsgi:application"]
