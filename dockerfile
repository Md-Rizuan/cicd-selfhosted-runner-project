# Base image
FROM python:3.12-slim

# Environment variable
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Work directory
WORKDIR /app

# Requirements copy
COPY requirements.txt /app/
# pip install --no-cache-dir -r requirements.txt

# Install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Project copy
COPY . /app/

# Run server
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]