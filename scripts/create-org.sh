#!/bin/bash 
echo 'Hello World'
echo $@

userDetails=$(sfdx force:org:create -f config/project-scratch-def.json -a $@ -s --json -d 1 -w 10)
LOGIN_USERNAME=$(echo $userDetails | jq -r .result.username)

# Generate password
sfdx force:user:password:generate --targetusername $LOGIN_USERNAME

# Get scratch org details
orgDetails=$(sfdx force:org:display -u $LOGIN_USERNAME --json)
LOGIN_PASSWORD=$(echo $orgDetails | grep -i password | awk '{print $2}' | sed 's/[",]//g')
LOGIN_INSTANCE_URL=$(echo $orgDetails | grep -i instanceUrl | awk '{print $2}' | sed 's/[",]//g')
LOGIN_ORG_ID=$(echo $orgDetails | grep -i id | awk 'NR==1{print $2}' | sed 's/[",]//g')
