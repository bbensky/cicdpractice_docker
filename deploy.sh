#!/bin/bash

SSH_IDENTIFIER=cicdpractice
SERVER=34.254.188.32

# Local Build, Run and Test
echo "Building the new image..."
docker build -t ethnopunk/docker_repo:$1 .

echo "Running a test container..."
docker run -d -p 4567:4567 --name helloworld ethnopunk/docker_repo:$1

echo "Testing that the container was created successfully"
if docker container ls | grep --quiet $1
then
  echo "Container created..."
else
  echo "Container not created. Terminating script..."
  exit 1
fi

echo "Testing the web server..."
sleep 1
if [ $(curl -s -o /dev/null -w "%{http_code}" localhost:4567) -eq 200 ]
then 
  echo "Web server test successful..."
else
  echo "Web server test unsuccessful. Terminating script..."
  exit 1
fi

echo "Stopping the test container..."
docker kill helloworld

echo "Removing the test container..."
docker rm helloworld

# Push to repository
echo "Pushing image to container registry..."
docker push ethnopunk/docker_repo:$1

# VM Pull, Build, Run and Test

echo "Stopping container with previous version on VM..."
ssh cicdpractice "docker kill helloworld"

echo "Removing container with previous version on VM..."
ssh cicdpractice "docker rm helloworld"

echo "Pulling image from container registry to VM..."
ssh cicdpractice "docker pull ethnopunk/docker_repo:$1"

echo "Running container on VM..."
ssh cicdpractice "docker run -d -p 4567:4567 --name helloworld ethnopunk/docker_repo:$1"

echo "Testing that container was created successfully on VM..."
if ssh cicdpractice "docker container ls | grep --quiet $1"
then
  echo "Container created..."
else
  echo "Container not created. Terminating script..."
  exit 1
fi

echo "Testing web server on VM..."
sleep 1
if [ $(curl -s -o /dev/null -w "%{http_code}" $SERVER:4567) -eq 200 ]
then 
  echo "Web server test successful..."
else
  echo "Web server test unsuccessful. Terminating script..."
  exit 1
fi

echo "New version deployed."
