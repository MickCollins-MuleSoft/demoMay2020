echo $1 $2 $3 $4 $5 $6 $7

client_id=$1
client_secret=$2
mysqlHost=$3
mysqlPort=$4
mysqlUsername=$5
mysqlPassword=$6
mysqlDatabase=$7

accessToken=$(curl -sk https://gov.anypoint.mulesoft.com/accounts/api/v2/oauth2/token \
-H 'Content-Type: application/json' \
-d "{ 
	\"client_id\" : \"$client_id\", 
	\"client_secret\": \"$client_secret\", 
	\"grant_type\" : \"client_credentials\"
}" | /usr/local/bin/jq --raw-output .access_token)

echo "Access Token $accessToken"

/usr/local/bin/mvn -f mysql-deploy-govcloud-api/pom.xml clean package deploy -DmuleDeploy -DauthorizationToken=$accessToken -Dmysql.host=$mysqlHost -Dmysql.port=$mysqlPort -Dmysql.username=$mysqlUsername -Dmysql.password=$mysqlPassword -Dmysql.database=$mysqlDatabase -DmuleDeploy

echo End of Script