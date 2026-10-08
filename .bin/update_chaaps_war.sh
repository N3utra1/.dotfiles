#!/bin/bash -e
BRANCH=$(git branch --show-current)
if [ -z "$BRANCH" ]; then
  echo "Please enter a branch name"
  exit 1
fi

ssh -i /home/will/ep2-eu-west-2.pem ec2-user@ec2-13-134-131-160.eu-west-2.compute.amazonaws.com "sudo /bin/bash /root/update_webserver.sh '$BRANCH'"
