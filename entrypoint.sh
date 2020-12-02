#!/bin/bash
set -e
ERROR=0
echo " ************** MODIFIED FILES"
printf ${MODIFIED_FILES}
printf "\n*****************************\n"


PATHS=$(printf ${MODIFIED_FILES} | tr \\n '\n')
while read -r local_file && [ ! -z "$local_file" ];
do
    echo $local_file
    #all local files must be found in changed files
    if ! grep "^$local_file\$" <<< "$PATHS" >/dev/null; then
        echo "Not found changes in local file '$local_file' when core file changed." >&2
        ERROR=102
    fi
    
    
    if [[ $local_file =~ ^app\/code\/local\/Mage\/(.+)$ ]] ; then
        echo "Unchangeable file is changed: ${PATH}"
        ERROR=1
    fi
    
    
    if [[ ${PATH} =~ ^app\/code\/community\/(.+)$ ]] ; then
        echo "Community file is changed: ${PATH}"
        ERROR=1
    fi

done < <(grep -P '^app/code/core/.' <<< "$PATHS" | sed --expression='s/^app\/code\/core/app\/code\/local/g')

# prevent overrides in cummunity directory
community_overrides=$(grep -P '^app/code/community/.' <<< "$PATHS" | sed --expression='s/^app\/code\/community/app\/code\/core/g')
echo "$community_overrides" | while read CORE_FILE ; do
    if [[ -f $CORE_FILE ]]
    then
        echo "Found overrides in 'app/code/community/'! If you need override core file, you must use local scope, not community. The file is: $CORE_FILE"
        ERROR=103
    fi
done


exit "${ERROR}"
