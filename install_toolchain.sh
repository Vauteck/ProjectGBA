#!/bin/bash

sudo mkdir -p /opt/ && sudo chown `id -u -n`:`id -g -n` /opt/ && cp devkitpro.tar.gz /opt && tar xvzf devkitpro.tar.gz
