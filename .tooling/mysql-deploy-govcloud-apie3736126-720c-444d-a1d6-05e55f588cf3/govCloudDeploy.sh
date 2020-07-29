client_id=$1
client_secret=$2

accessToken=$(curl -sk https://gov.anypoint.mulesoft.com/accounts/api/v2/oauth2/token \
-H 'Content-Type: application/json' \
-d "{ 
	\"client_id\" : \"$client_id\", 
	\"client_secret\": \"$client_secret\", 
	\"grant_type\" : \"client_credentials\"
}" | jq --raw-output .access_token)

echo "Access Token $accessToken"

mvn -f pom.xml clean package deploy -DmuleDeploy -DauthorizationToken=$accessToken

echo End of Script