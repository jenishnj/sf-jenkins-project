#!/bin/bash 
echo 'Hello World'
echo $@

LOGIN_USERNAME='test-xr8i0fahlfqc@example.com'

# Generate password
# sfdx force:user:password:generate --targetusername $LOGIN_USERNAME

# Get scratch org details
# orgDetails=$(sfdx force:org:display -u $LOGIN_USERNAME --json)
# echo $orgDetails | grep -i password
LOGIN_PASSWORD=$(cat temp.json | awk '/password/ {print $2}' | sed 's/[",]//g')
LOGIN_INSTANCE_URL=$(cat temp.json | awk '/instanceUrl/ {print $2}' | sed 's/[",]//g')
LOGIN_ORG_ID=$(cat temp.json | awk '/id/ {print $2;exit}' | sed 's/[",]//g')
echo "LOGIN_ORG_ID=$LOGIN_ORG_ID" >> .env
echo "LOGIN_INSTANCE_URL=$LOGIN_INSTANCE_URL" >> .env
echo "LOGIN_USERNAME=$LOGIN_USERNAME" >> .env
echo "LOGIN_PASSWORD=$LOGIN_PASSWORD" >> .env
rm -rf temp.json
