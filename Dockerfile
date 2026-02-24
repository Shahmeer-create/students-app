# -------------------------------
# Updated Dockerfile for Security
# -------------------------------

# Use latest secure Python slim image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt .

# Upgrade pip, setuptools, wheel and install dependencies
RUN pip install --upgrade pip setuptools wheel \
    && pip install --no-cache-dir -r requirements.txt

# Copy rest of application
COPY . .

# Create directory for database
RUN mkdir -p /app/data

# Set environment variables for better security
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    FLASK_ENV=production

# Expose the port Flask runs on
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
