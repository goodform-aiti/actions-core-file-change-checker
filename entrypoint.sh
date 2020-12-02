#!/bin/bash
set -e
ERROR=0
echo " ************** MODIFIED FILES"
printf ${MODIFIED_FILES}
printf "\n*****************************\n"


#PATHS=(${MODIFIED_FILES//\\n / })
PATHS=$(printf ${MODIFIED_FILES} | tr \\n '\n')
#for i in "${!PATHS[@]}"
echo "$PATHS" | while read PATH
do
    
    echo ${PATH}
    

    if [[ ${PATH} =~ ^app\/code\/core\/(.+)$ ]] ; then
      LOCAL_FILE=$(echo ${PATH} | sed  --expression='s/^app\/code\/core/app\/code\/local/g')
      if [[ ! " ${PATHS[@]} " =~ " ${LOCAL_FILE} " ]]; then
          echo "Not found changes in local file '$LOCAL_FILE' when core file changed." >&2
          ERROR=1
      fi
    fi
    
    echo "hoooy"
    if [[ ${PATH} =~ ^app\/code\/local\/Mage\/(.+)$ ]] ; then
        echo "Unchangeable file is changed: ${PATH}"
        ERROR=1
    fi
    
        
    if [[ ${PATH} =~ ^app\/code\/community\/(.+)$ ]] ; then
        echo "Community file is changed: ${PATH}"
        ERROR=1
    fi
done

exit "${ERROR}"
