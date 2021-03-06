GCP_SA_KEY_FILE=./gcp-sa-cloud-build.json
echo $GCP_SA_CLOUD_BUILD > $GCP_SA_KEY_FILE
export GOOGLE_APPLICATION_CREDENTIALS=$GCP_SA_KEY_FILE

echo "starting cloud build to $APIGEE_ORG/$APIGEE_ENV"

DEPLOYMENT_SUFFIX="-devrel-pipeline"

SUBSTITUTIONS="_INT_TEST_BASE_PATH=/airports-cicd$DEPLOYMENT_SUFFIX/v1"
SUBSTITUTIONS="$SUBSTITUTIONS,_DEPLOYMENT_ORG=$APIGEE_ORG"
SUBSTITUTIONS="$SUBSTITUTIONS,_DEPLOYMENT_ENV=$APIGEE_ENV"
SUBSTITUTIONS="$SUBSTITUTIONS,_DEPLOYMENT_SUFFIX=$DEPLOYMENT_SUFFIX"

gcloud builds submit --config=cloudbuild-saas.yaml \
  --substitutions=$SUBSTITUTIONS

rm $GCP_SA_KEY_FILE