#Get information about all clusters in a project
curl -i -u "${PUBLICKEY}:${PRIVATEKEY}" --digest "https://cloud.mongodb.com/api/atlas/v1.0/groups/${PROJECTID}/clusters?pretty=true"

#Get events
curl --user "${PUBLICKEY}:${PRIVATEKEY}" --digest --include \
  --header "Content-Type: application/json" \
  "https://cloud.mongodb.com/api/atlas/v1.0/groups/${PROJECTID}/events?pretty=true"


#create a cluster (not available on free tier)
curl --user "${PUBLICKEY}:${PRIVATEKEY}" --digest \
  --header "Content-Type: application/json" \
  --include \
  --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/${PROJECTID}/clusters?pretty=true" \
  --data '
    {
      "name" : "DataStore",
      "diskSizeGB" : 10,
      "numShards" : 1,
      "providerSettings" : {
        "providerName" : "AWS",
        "diskIOPS" : 100,
        "instanceSizeName" : "M10",
        "regionName" : "US_EAST_1"
      },
      "replicationFactor" : 3,
      "backupEnabled" : true,
      "autoScaling":{"diskGBEnabled":true}
    }'


#Modify a cluster (not available on free tier)
curl --user "${PUBLICKEY}:${PRIVATEKEY}" --digest \
  --header "Accept: application/json" \
  --header "Content-Type: application/json" \
  --include \
  --request PATCH "https://cloud.mongodb.com/api/atlas/v1.0/groups/${PROJECTID}/clusters/DataStore?pretty=true" \
  --data '
    {
      "paused":"false"
    }'


