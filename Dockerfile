# Use a lightweight Python base image
FROM python:3.11-slim

# Set working directory inside the container
WORKDIR /app

# Copy your project files into the container
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir boto3 pandas

# Set environment variable for AWS region (optional, can also set outside)
ENV AWS_DEFAULT_REGION=eu-west-1

# Run the telemetry script
CMD ["python", "telemetry_uploader.py"]
