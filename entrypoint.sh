#!/bin/bash
set -e
ERROR=0
echo " ************** MODIFIED FILES"
printf ${MODIFIED_FILES}
printf "\n*****************************\n"



PATHS=$(printf ${MODIFIED_FILES} | tr \\n '\n')
echo "$PATHS" | while read PATH
do
    if [[ ${PATH} =~ ^app\/code\/core\/(.+)$ ]] ; then
      LOCAL_FILE=$(echo ${PATH} | sed  --expression='s/^app\/code\/core/app\/code\/local/g')
      if [[ ! " ${PATHS[@]} " =~ " ${LOCAL_FILE} " ]]; then
          echo "Not found changes in local file '$LOCAL_FILE' when core file changed." >&2
          ERROR=1
      fi
    fi
        
    if [[ ${PATH} =~ ^app\/code\/community\/(.+)$ ]] ; then
        echo "Community file is changed: ${PATH}"
        ERROR=1
    fi
done

exit "${ERROR}"
