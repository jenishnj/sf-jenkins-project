#!/bin/bash 

# Create scratch org
userDetails=$(sfdx force:org:create -f config/project-scratch-def.json -s --json -d 1 -w 10)
LOGIN_USERNAME=$(echo $userDetails | jq -r .result.username)
# LOGIN_USERNAME='test-xr8i0fahlfqc@example.com'

# Generate password
sfdx force:user:password:generate --targetusername $LOGIN_USERNAME

# Get scratch org details
sfdx force:org:display -u $LOGIN_USERNAME --json >> temp.json

LOGIN_PASSWORD=$(cat temp.json | awk '/password/ {print $2}' | sed 's/[",]//g')
LOGIN_INSTANCE_URL=$(cat temp.json | awk '/instanceUrl/ {print $2}' | sed 's/[",]//g')
LOGIN_ORG_ID=$(cat temp.json | awk '/id/ {print $2;exit}' | sed 's/[",]//g')
echo "LOGIN_ORG_ID=$LOGIN_ORG_ID" >> .env
echo "LOGIN_INSTANCE_URL=$LOGIN_INSTANCE_URL" >> .env
echo "LOGIN_USERNAME=$LOGIN_USERNAME" >> .env
echo "LOGIN_PASSWORD=$LOGIN_PASSWORD" >> .env
rm -rf temp.json
