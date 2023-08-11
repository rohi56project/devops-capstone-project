# Dockerfile

# Use the python:3.9-slim image as the base
FROM python:3.9-slim

# Set the working directory to /app
WORKDIR /app

# Copy the requirements.txt file to the working directory
COPY requirements.txt .

# Install the requirements using pip, without caching
RUN pip install --no-cache-dir -r requirements.txt

# Copy the service package to the working directory
COPY service/ ./service/

# Create a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Expose port 8080
EXPOSE 8080

# Run the Gunicorn server
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]