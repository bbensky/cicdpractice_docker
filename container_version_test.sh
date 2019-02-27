#!/bin/bash

if docker container ls | grep --quiet $1
then echo "success"
fi