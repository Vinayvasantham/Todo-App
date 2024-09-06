# Use the official Python image from Docker Hub
FROM python:3.12-slim

# Install system dependencies required for Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-distutils \
    python3-pip \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Django using pip
RUN pip install --no-cache-dir django==3.2

# Copy the project files to the working directory
COPY . .

# Run migrations to set up the database
RUN python manage.py migrate

# Expose the port the app will run on
EXPOSE 8000

# Set the default command to run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]


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

