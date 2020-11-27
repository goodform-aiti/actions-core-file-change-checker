#!/bin/bash
set -e
ERROR=0
echo " ************** MODIFIED FILES"
printf ${MODIFIED_FILES}
printf "\n*****************************\n"


PATHS=(${MODIFIED_FILES//\\n / })
for i in "${!PATHS[@]}"
do
    
    

    if [[ ${PATHS[i]} =~ ^app\/code\/core\/(.+)$ ]] ; then
      LOCAL_FILE=$(echo ${PATHS[i]} | sed  --expression='s/^app\/code\/core/app\/code\/local/g')
      if [[ ! " ${PATHS[@]} " =~ " ${LOCAL_FILE} " ]]; then
          echo "Not found changes in local file '$LOCAL_FILE' when core file changed." >&2
          ERROR=1
      fi
    fi
    
    
    if [[ ${PATHS[i]} =~ ^app\/code\/local\/\(Mage\|Varien\)\/(.+)$ ]] ; then
        echo "Unchangeable file is changed: ${PATHS[i]}"
        ERROR=1
    fi
    
        
    if [[ ${PATHS[i]} =~ ^app\/code\/community\/(.+)$ ]] ; then
        echo "Community file is changed: ${PATHS[i]}"
        ERROR=1
    fi
done

exit "${ERROR}"
