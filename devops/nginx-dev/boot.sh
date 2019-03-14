#!/usr/bin/env bash

vars='\$REMOTE_DEBUG_HOST'

export REMOTE_DEBUG_HOST=${REMOTE_DEBUG_HOST}

envsubst "$vars" < "/etc/nginx/conf.d/default.conf.tpl" > "/etc/nginx/conf.d/default.conf"

nginx -g 'daemon off;'