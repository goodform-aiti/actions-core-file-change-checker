#!/bin/bash
set -e
ERROR=0
echo " ************** MODIFIED FILES"
echo ${MODIFIED_FILES}
echo " *****************************"


paths=(${MODIFIED_FILES//,/ })
for i in "${!paths[@]}"
do
    if [[ ${paths[i]} =~ ^app\/code\/core\/(.+)$ ]] ; then
      echo "Core file is changed: ${paths[i]}"
      ERROR=1
    fi
    if [[ ${paths[i]} =~ ^app\/design\/frontend\/base\/(.+)$ ]] ; then
        echo "Core Design file is changed: ${paths[i]}"
        ERROR=1
    fi
    if [[ ${paths[i]} =~ ^app\/design\/adminhtml\/base\/(.+)$ ]] ; then
        echo "Core Admin Design file is changed: ${paths[i]}"
        ERROR=1
    fi
    if [[ ${paths[i]} =~ ^app\/code\/community\/(.+)$ ]] ; then
        echo "Community file is changed: ${paths[i]}"
        ERROR=1
    fi
done

exit "${ERROR}"
