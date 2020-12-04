#!/bin/bash
set -e
ERROR=0

echo " ************** MODIFIED FILES"
printf ${MODIFIED_FILES}
printf "\n*****************************\n"


PATHS=$(printf ${MODIFIED_FILES} | tr \\n '\n')
while read -r local_file && [ ! -z "$local_file" ];
do

    #all local files must be found in changed files
    if ! grep "^$local_file\$" <<< "$PATHS" >/dev/null; then
        echo "Not found changes in local file '$local_file' when core file changed." >&2
        ERROR=102
    fi
    

done < <(grep -P '^app/code/core/.' <<< "$PATHS" | sed --expression='s/^app\/code\/core/app\/code\/local/g')



while read -r core_file && [ ! -z "$core_file" ];
do

    #all core files must be found in changed files
    if ! grep "^$core_file\$" <<< "$PATHS" >/dev/null; then
        echo "Not found changes in core file '$core_file' when local file changed." >&2
        ERROR=102
    fi
    

done < <(grep -P '^app/code/local/Mage/.' <<< "$PATHS" | sed --expression='s/^app\/code\/local/app\/code\/core/g')








echo "$PATHS" | while read PATH ; do
    if [[ ! -f $PATH ]]
    then
         # skip deleted files
         continue
    fi
    if [[ ${PATH} =~ ^(lib\/phpseclib|lib\/Zend|lib/PEAR)\/.+$ ]] ; then
        echo "Holy code changed: ${PATH}"
        ERROR=101
    fi
    if [[ ${PATH} =~ ^app\/design\/frontend\/base\/(.+)$ ]] ; then
        echo "Holy code changed: ${PATH}"
        ERROR=101
    fi
    if [[ ${PATH} =~ ^app\/code\/local\/Varien\/(.+)$ ]] ; then
        echo "Holy code changed: ${PATH}"
        ERROR=101
    fi
done


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
