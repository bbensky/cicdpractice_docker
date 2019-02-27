#!/bin/bash

if [ $(curl -s -o /dev/null -w "%{http_code}" localhost:4567) -eq 200 ]
then echo 'Web server test successful.'
else
  echo 'Web server test unsuccessful. Terminating script.'
  exit 1
fi