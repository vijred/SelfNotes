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
*   Show me the list of images - `docker images `, Look for specific image `docker images | grep astro-custom`, , Look for specific image `docker images | wsl grep astro-custom`
*   Run interactive shell inside image - `docker run --rm -it astro-custom /bin/bash`, use this if bash is not available `docker run --rm -it astro-custom /bin/sh`
  *  How to start/run as root - `docker run --rm -it --user root astro-custom /bin/bash`
*   How to stop the container - `docker stop containerid`; If -rm is nto used while starting, use this command toremove - `docker rm <containerid>`
```
c:\git\local\astro>docker ps
CONTAINER ID  IMAGE                          COMMAND     CREATED         STATUS         PORTS       NAMES
7e2ad02b7591  localhost/astro-custom:latest  /bin/bash   45 minutes ago  Up 45 minutes              eager_burnell

c:\git\local\astro>docker stop 7e2ad02b7591
```
*   
*   Few common commands to check the image -
```
whoami
id
pwd
python --version
pip list | head
pip show <my-packge-name>
# Look for environment variables
env | sort
echo $AIRFLOW_HOME

```
*   


## Example Docker files

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
* Best way to add a certificate to existing container and build a new container -
```
FROM quay.io/astronomer/astro-runtime:11.7.0
USER root
COPY paychex.pem /usr/local/share/ca-certificates/mydomainname/mycertname.crt
RUN update-ca-certificates
USER astro
```










