#!/bin/bash
set -e
ERROR=0
echo " ************** MODIFIED FILES"
echo ${MODIFIED_FILES}
echo " *****************************"


paths=(${MODIFIED_FILES//,/ })
for i in "${!paths[@]}"
do
#     if [[ ${paths[i]} =~ ^app\/code\/core\/(.+)$ ]] ; then
#       echo "Core file is changed: ${paths[i]}"
#       ERROR=1
#     fi
    
    
    
    while read -r local_file && [ ! -z "$local_file" ];	
    do	
        #all local files must be found in changed files	
        if ! grep "^$local_file\$" <<< "$MODIFIED_FILES" >/dev/null; then	
            echo "Not found changes in local file '$local_file' when core file changed." >&2	
            exit_code=102	
        fi	

    done < <(grep -P '^app/code/core/.' <<< "$MODIFIED_FILES" | sed --expression='s/^app\/code\/core/app\/code\/local/g' | xargs -r -l -d'\n' find 2>/dev/null)
    
    
    
    
    
    
    if [[ ${paths[i]} =~ ^app\/code\/community\/(.+)$ ]] ; then
        echo "Community file is changed: ${paths[i]}"
        ERROR=1
    fi
done

exit "${ERROR}"
