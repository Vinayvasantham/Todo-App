# Use the official Python image from the Docker Hub
FROM python:3.12-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /app

# Install necessary build tools and PostgreSQL development libraries
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gcc \
    python3-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the image
COPY requirements.txt /app/

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the entire project into the image
COPY . /app/

# Expose the port the app runs on
EXPOSE 8090

# Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8090"]




# FROM python:3
# RUN pip install django==3.2

# COPY . .

# RUN python manage.py migrate
# EXPOSE 8000
# CMD ["python","manage.py","runserver","0.0.0.0:8000"]

# # Use the official Python image from the Docker Hub
# FROM python:3.9-slim

# # Set environment variables
# # ENV PYTHONDONTWRITEBYTECODE 1
# # ENV PYTHONUNBUFFERED 1

# # Set the working directory
# WORKDIR /app

# # Copy the requirements file into the image
# COPY requirements.txt /app/

# # Install the dependencies
# # RUN pip install --no-cache-dir -r requirements.txt
# RUN pip install --no-cache-dir --upgrade pip && \
#     pip install --no-cache-dir -r requirements.txt

# # Copy the entire project into the image
# COPY . /app/

# # Expose the port the app runs on
# EXPOSE 8000

# # Run the Django development server
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

