#!/bin/bash 
echo 'Hello World'
echo $@

LOGIN_USERNAME='test-ojt6na8ivhjm@example.com'

# Generate password
sfdx force:user:password:generate --targetusername $LOGIN_USERNAME

# Get scratch org details
orgDetails=$(sfdx force:org:display -u $LOGIN_USERNAME --json)
LOGIN_PASSWORD=$(echo $orgDetails | grep -i password | awk '{print $2}' | sed 's/[",]//g')
LOGIN_INSTANCE_URL=$(echo $orgDetails | grep -i instanceUrl | awk '{print $2}' | sed 's/[",]//g')
LOGIN_ORG_ID=$(echo $orgDetails | grep -i id | awk 'NR==1{print $2}' | sed 's/[",]//g')
