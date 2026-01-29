Docker
=====

* Build Image - `docker build -t my-python-app .`
* List Images - `docker images`
* Run Container - `docker run -p 8080:80 my-python-app`
  *   Note - Maps local port 8080 → container port 80
*   Run Container in Detached Mode - `docker run -d -p 8080:80 my-python-app`
*   List Running Containers - `docker ps`
*   List All Containers (including stopped) - `docker ps -a`
*   Stop Container - `docker stop <container_id>`
*   Start Stopped Container - `docker start <container_id>`
*   Remove Container - `docker rm <container_id>` , on powershell, remove using this command - `docker rm -f $(docker ps -aq)`
*   Remove Image - `docker rmi my-python-app`
*   Docket context list - `docker context ls`; how to configure the default version - `docker context use desktop-linux`
*   Sample Docker file while building the image
```
# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 80
EXPOSE 80

# Define environment variable
ENV NAME World

# Run the application
CMD ["python", "app.py"]
```











