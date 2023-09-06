#!/bin/bash

# This script was created to make delivering bundles much easier.
# It uses the templates in the 'stable' directory to make sure the tre pipeline and make file are updated appropriately.
# it does not do anything with the 'beta' directory which should only be used for development and the bundle pipeline.

TPL_DIR=stable

# Compile User Resources
find . -name porter.yaml|grep ${TPL_DIR} |grep user_resources|while read line
do
    bndle=$(dirname $line)
    bndle_nodot="${bndle#./}"
    grep $bndle_nodot ./.github/workflows/deploy_tre_reusable.yml
    if [ $? != "0" ]
    then
    echo "          - {
              BUNDLE_TYPE: \"user_resource\",
              BUNDLE_DIR: \"${bndle}\",
              WORKSPACE_SERVICE_NAME: \"tre-service-guacamole\"
            }" >> /tmp/REGISTERUSERBUNDLES
    echo "          - {
              BUNDLE_TYPE: \"user_resource\",
              BUNDLE_DIR: \"${bndle}\"
            }"  >> /tmp/PUBLISHALLBUNDLES
    fi
done

find . -name porter.yaml|grep ${TPL_DIR} |grep user_resources|grep linux|while read line
do
    bndle=$(dirname $line)
    bndle_nodot="${bndle#./}"
    grep $bndle_nodot Makefile
    if [ $? != "0" ]
    then
    echo "	\$(MAKE) bundle-build bundle-publish bundle-register DIR=\"${bndle_nodot}\" BUNDLE_TYPE=user_resource tre-service-guacamole-linuxvm" >> /tmp/MAKEFILECOMMANDS
    echo "" >> /tmp/MAKEFILE
    fi
done

find . -name porter.yaml|grep ${TPL_DIR} |grep user_resources|grep windows|while read line
do
    bndle=$(dirname $line)
    bndle_nodot="${bndle#./}"
    grep $bndle_nodot Makefile
    if [ $? != "0" ]
    then
    echo "	\$(MAKE) bundle-build bundle-publish bundle-register DIR=\"${bndle_nodot}\" BUNDLE_TYPE=user_resource tre-service-guacamole-windowsvm" >> /tmp/MAKEFILECOMMANDS
    echo "" >> /tmp/MAKEFILE
    fi
done

# Compile Workspace's
find . -name porter.yaml|grep ${TPL_DIR} |grep workspace|grep -v service|while read line
do
    bndle=$(dirname $line)
    grep $bndle ./.github/workflows/deploy_tre_reusable.yml
    if [ $? != "0" ]
    then
    echo "          - {
              BUNDLE_TYPE: \"workspace\",
              BUNDLE_DIR: \"${bndle}\"
            }"  >> /tmp/REGISTERWSBUNDLES
    echo "          - {
              BUNDLE_TYPE: \"workspace\",
              BUNDLE_DIR: \"${bndle}\"
            }"  >> /tmp/PUBLISHALLBUNDLES
    fi
done

# Compile Workspace services
find . -name porter.yaml|grep ${TPL_DIR} |grep workspace|grep service|while read line
do
    bndle=$(dirname $line)
    grep $bndle ./.github/workflows/deploy_tre_reusable.yml
    if [ $? != "0" ]
    then
    echo "          - {
              BUNDLE_TYPE: \"workspace_service\",
              BUNDLE_DIR: \"${bndle}\"
            }"  >> /tmp/REGISTERWSBUNDLES
    echo "          - {
              BUNDLE_TYPE: \"workspace_service\",
              BUNDLE_DIR: \"${bndle}\"
            }"  >> /tmp/PUBLISHALLBUNDLES
    fi
done

# Compile Shared services
find . -name porter.yaml|grep ${TPL_DIR} |grep shared|while read line
do
    bndle=$(dirname $line)
    grep $bndle ./.github/workflows/deploy_tre_reusable.yml
    if [ $? != "0" ]
    then
    echo "          - {
              BUNDLE_TYPE: \"shared_service\",
              BUNDLE_DIR: \"${bndle}/\"
            }"  >> /tmp/REGISTERSSBUNDLES
    echo "          - {
              BUNDLE_TYPE: \"shared_service\",
              BUNDLE_DIR: \"${bndle}/\"
            }"  >> /tmp/PUBLISHALLBUNDLES
    fi
done

home_dir=`pwd`
cd .github/workflows

if [ -s /tmp/PUBLISHALLBUNDLES ]
then
    echo "          #PUBLISHALLBUNDLES" >> /tmp/PUBLISHALLBUNDLES
    sed '/#PUBLISHALLBUNDLES/ {
        r /tmp/PUBLISHALLBUNDLES
        d
    }' deploy_tre_reusable.yml > temp_file && mv temp_file deploy_tre_reusable.yml
fi

if [ -s /tmp/REGISTERSSBUNDLES ]
then
    echo "          #REGISTERSHAREDBUNDLES" >> /tmp/REGISTERSSBUNDLES
    sed '/#REGISTERSHAREDBUNDLES/ {
        r /tmp/REGISTERSSBUNDLES
        d
    }' deploy_tre_reusable.yml > temp_file && mv temp_file deploy_tre_reusable.yml
fi

if [ -s /tmp/REGISTERWSBUNDLES ]
then
    echo "          #REGISTERWSBUNDLES" >> /tmp/REGISTERWSBUNDLES
    sed '/#REGISTERWSBUNDLES/ {
        r /tmp/REGISTERWSBUNDLES
        d
    }' deploy_tre_reusable.yml > temp_file && mv temp_file deploy_tre_reusable.yml
fi

if [ -s /tmp/REGISTERUSERBUNDLES ]
then
    echo "          #REGISTERUSERBUNDLES" >> /tmp/REGISTERUSERBUNDLES
    sed '/#REGISTERUSERBUNDLES/ {
        r /tmp/REGISTERUSERBUNDLES
        d
    }' deploy_tre_reusable.yml > temp_file && mv temp_file deploy_tre_reusable.yml
fi

if [ -s /tmp/MAKEFILE ]
then
    echo "	#MAKEFILECOMMANDS" >> /tmp/MAKEFILE
fi


cd $home_dir

if [ -s /tmp/REGISTERUSERBUNDLES ]
then
    sed '/#MAKEFILECOMMANDS/ {
        r /tmp/MAKEFILECOMMANDS
        d
    }' Makefile > temp_file && mv temp_file Makefile
fi
