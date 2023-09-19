#!/bin/bash

# This script was created to make delivering bundles much easier.
# It uses the templates in the 'stable' directory to make sure the tre pipeline and make file are updated appropriately.
# it does not do anything with the 'beta' directory which should only be used for development and the bundle pipeline.
# Arguments to pass in are $1 the env name and $2 your PAT token for git.

env=$1
export GH_TOKEN=$2

gal='{"image_gallery_id":"/subscriptions/<subscription_id>/resourceGroups/<rg_name>/providers/Microsoft.Compute/galleries/<gal_name>"}'

# adding Dummy secrets
gh secret set TEST_APP_ID --env $env --body "dummy"
gh secret set TEST_WORKSPACE_APP_ID --env $env --body "dummy"
gh secret set TEST_WORKSPACE_APP_SECRET --env $env --body "dummy"
gh secret set MS_TEAMS_WEBHOOK_URI --env $env --body "dummy"

# Adding value secrets
gh variable set AZURE_ENVIRONMENT --env $env --body "AzureCloud"
gh variable set ENABLE_SWAGGER --env $env --body "true"
gh variable set CUSTOM_TAG_KEY_1 --env $env --body "custom_tag_key_1"
gh variable set CUSTOM_TAG_KEY_2 --env $env --body "custom_tag_key_2"
gh variable set CUSTOM_TAG_KEY_3 --env $env --body "custom_tag_key_3"
gh variable set CUSTOM_TAG_KEY_4 --env $env --body "custom_tag_key_4"
gh variable set CUSTOM_TAG_KEY_5 --env $env --body "custom_tag_key_5"
gh variable set CUSTOM_TAG_KEY_6 --env $env --body "custom_tag_key_6"

gh variable set CUSTOM_TAG_ENUM_1 --env $env --body '"custom_tag_enum_1"'
gh variable set CUSTOM_TAG_ENUM_2 --env $env --body '"custom_tag_enum_2"'
gh variable set CUSTOM_TAG_ENUM_3 --env $env --body '"custom_tag_enum_3"'

# adding dynamic variables
LOCATION=`grep -i LOCATION config.yaml|awk '{print $2}'`
gh variable set LOCATION --env $env --body $LOCATION
TERRAFORM_STATE_CONTAINER_NAME=`grep -i TERRAFORM_STATE_CONTAINER_NAME config.yaml|awk '{print $2}'`
gh variable set TERRAFORM_STATE_CONTAINER_NAME --env $env --body $TERRAFORM_STATE_CONTAINER_NAME
gh variable set RP_BUNDLE_VALUES --env $env --body $gal

L=`grep -i L config.yaml|awk '{print $2}'`

# adding blank secrets
AAD_TENANT_ID=`grep -i AAD_TENANT_ID config.yaml|awk '{print $2}'`
gh secret set AAD_TENANT_ID --env $env --body $AAD_TENANT_ID
ACR_NAME=`grep -i ACR_NAME config.yaml|awk '{print $2}'`
gh secret set ACR_NAME --env $env --body $ACR_NAME
gh secret set AZURE_CREDENTIALS --env $env --body "dummy"
API_CLIENT_ID=`grep -i API_CLIENT_ID config.yaml|awk '{print $2}'`
gh secret set API_CLIENT_ID --env $env --body $API_CLIENT_ID
API_CLIENT_SECRET=`grep -i API_CLIENT_SECRET config.yaml|awk '{print $2}'`
gh secret set API_CLIENT_SECRET --env $env --body $API_CLIENT_SECRET
APPLICATION_ADMIN_CLIENT_ID=`grep -i APPLICATION_ADMIN_CLIENT_ID config.yaml|awk '{print $2}'`
gh secret set APPLICATION_ADMIN_CLIENT_ID --env $env --body $APPLICATION_ADMIN_CLIENT_ID
APPLICATION_ADMIN_CLIENT_SECRET=`grep -i APPLICATION_ADMIN_CLIENT_SECRET config.yaml|awk '{print $2}'`
gh secret set APPLICATION_ADMIN_CLIENT_SECRET --env $env --body $APPLICATION_ADMIN_CLIENT_SECRET
MGMT_RESOURCE_GROUP_NAME=`grep -i MGMT_RESOURCE_GROUP_NAME config.yaml|awk '{print $2}'`
gh secret set MGMT_RESOURCE_GROUP_NAME --env $env --body $MGMT_RESOURCE_GROUP_NAME
MGMT_STORAGE_ACCOUNT_NAME=`grep -i MGMT_STORAGE_ACCOUNT_NAME config.yaml|awk '{print $2}'`
gh secret set MGMT_STORAGE_ACCOUNT_NAME --env $env --body $MGMT_STORAGE_ACCOUNT_NAME
SWAGGER_UI_CLIENT_ID=`grep -i SWAGGER_UI_CLIENT_ID config.yaml|awk '{print $2}'`
gh secret set SWAGGER_UI_CLIENT_ID --env $env --body $SWAGGER_UI_CLIENT_ID
TEST_ACCOUNT_CLIENT_ID=`grep -i TEST_ACCOUNT_CLIENT_ID config.yaml|awk '{print $2}'`
gh secret set TEST_ACCOUNT_CLIENT_ID --env $env --body $TEST_ACCOUNT_CLIENT_ID
TEST_ACCOUNT_CLIENT_SECRET=`grep -i TEST_ACCOUNT_CLIENT_SECRET config.yaml|awk '{print $2}'`
gh secret set TEST_ACCOUNT_CLIENT_SECRET --env $env --body $TEST_ACCOUNT_CLIENT_SECRET
TRE_ID=`grep -i TRE_ID config.yaml|awk '{print $2}'`
gh secret set TRE_ID --env $env --body $TRE_ID
arm_subscription_id=`grep -i arm_subscription_id config.yaml|awk '{print $2}'`

echo ""
echo " copy the below json credential template. add you SP credentials to it and modify the secret 'AZURE_CREDENTIALS' in your git environment using it"
echo "{
  \"clientId\": \"YOUR SP CLIENT ID\",
  \"clientSecret\": \"YOUR SP CLIENT SECRET\",
  \"subscriptionId\": \"$arm_subscription_id\",
  \"tenantId\": \"$AAD_TENANT_ID\"
}"
