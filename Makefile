SHELL:=/bin/bash

AZURETRE_HOME?="AzureTRE"

include $(AZURETRE_HOME)/Makefile

.PHONY: build_and_publish

build_and_publish:
	$(MAKE) bundle-build bundle-publish bundle-register \
	DIR="templates/stable/user_resources/Linux-VM-With-DataDisk" BUNDLE_TYPE=user_resource tre-service-guacamole

	$(MAKE) bundle-build bundle-publish bundle-register \
	DIR="templates/stable/user_resources/Windows-VM-With-DataDisk" BUNDLE_TYPE=user_resource tre-service-guacamole

  #MAKEFILECOMMANDS
