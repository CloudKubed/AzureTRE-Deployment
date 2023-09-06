set -vx
OSS_VERSION=$1
OSS_ORG=$2
pwd
# edit the OSS version
sed -i "s/OSS_VERSION_VAR/${OSS_VERSION}/g" .devcontainer/devcontainer.json
# edit the OSS org
sed -i "s/OSS_ORG_VAR/${OSS_ORG}/g" .devcontainer/scripts/install_azure-tre-oss.sh
