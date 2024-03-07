#!/bin/bash

source env_setup.sh && \
	cd ${DEVKITADV}/bin && \
	make -C ${PROJECT_DIRECTORY}
