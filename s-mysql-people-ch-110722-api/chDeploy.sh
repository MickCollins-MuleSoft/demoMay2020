echo '->1:' $1 ' 2:' $2 ' 3:'$3 ' 4:' $4 ' 5:' $5 ' 6:' $6 ' 7:' $7

client_id=$1
client_secret=$2
mysqlHost=$3
mysqlPort=$4
mysqlUser=$5
mysqlPassword=$6
mysqlDatabase=$7


export JAVA_HOME=$(/usr/libexec/java_home)
PATH=/usr/local/bin;
export PATH
PATH=$PATH:/usr/bin;
export PATH
PATH=$PATH:/bin;
export PATH
PATH=$PATH:/usr/sbin;
export PATH
PATH=$PATH:/sbin;
export PATH
PATH=$JAVA_HOME:$PATH;
export PATH


# ========================================================================
# Script was copied from app to deploy to GovCloud using Connected App
# Commenting out, yet preserving commands for that deployment
#
# accessToken=$(curl -sk https://gov.anypoint.mulesoft.com/accounts/api/v2/oauth2/token \
# -H 'Content-Type: application/json' \
# -d "{
#	\"client_id\" : \"$client_id\", 
# 	\"client_secret\": \"$client_secret\", 
# 	\"grant_type\" : \"client_credentials\"
# }" | /usr/local/bin/jq --raw-output .access_token)

# echo "Access Token $accessToken"

accessToken=$(curl -sk https://anypoint.mulesoft.com/accounts/api/v2/oauth2/token \
 -H 'Content-Type: application/json' \
 -d "{
	\"client_id\" : \"$client_id\", 
 	\"client_secret\": \"$client_secret\", 
 	\"grant_type\" : \"client_credentials\" }" | /usr/local/bin/jq --raw-output .access_token)

echo "Access Token $accessToken"

# /usr/local/bin/mvn -f mysql-deploy-ch-api/pom.xml clean package deploy -DmuleDeploy -DauthorizationToken=$accessToken -Dmysql.host=$mysqlHost -Dmysql.port=$mysqlPort -Dmysql.username=$mysqlUser -Dmysql.password=$mysqlPassword -Dmysql.database=$mysqlDatabase
#
# ========================================================================

echo 'RUNNING MAVEN: /usr/local/bin/mvn -f s-mysql-people-ch-110722-api/pom.xml clean package deploy -DmuleDeploy -Dmysql.host=' $mysqlHost ' -Dmysql.port=' $mysqlPort ' -Dmysql.user=' $mysqlUser ' -Dmysql.password=' $mysqlPassword ' -Dmysql.database=' $mysqlDatabase
/usr/local/bin/mvn -f s-mysql-people-ch-110722-api/pom.xml clean package deploy -DmuleDeploy -Dmysql.host=$mysqlHost -Dmysql.port=$mysqlPort -Dmysql.user=$mysqlUser -Dmysql.password=$mysqlPassword -Dmysql.database=$mysqlDatabase -DauthorizationToken=$accessToken 

echo End of Script

