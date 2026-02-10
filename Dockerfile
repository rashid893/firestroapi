FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && \
    apt-get install -y build-essential libpq-dev curl && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV DJANGO_SETTINGS_MODULE=myproject.settings

# EXPOSE is optional; Cloud Run ignores it
EXPOSE 8000

# 🔥 THIS LINE IS THE FIX
CMD ["sh", "-c", "python manage.py runserver 0.0.0.0:$PORT"]