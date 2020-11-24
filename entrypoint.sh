#!/bin/sh
set -e
ERROR=0
echo " ************** MODIFIED FILES"
echo ${MODIFIED_FILES}

echo "**************** changed files php"
echo ${CHANGED_FILES_PHP}

CHANGED_CORE_FILES=$(find ${MODIFIED_FILES} -type f -regex "^\(app/code/core\|app/design/frontend/base\|app/design/adminhtml/base\|app/code/community\)/.+$" 2>/dev/null)

echo "*************CHANGED_CORE_FILES"
echo ${CHANGED_CORE_FILES}



for file in ${CHANGED_CORE_FILES}; do		
    RESULTS="Unchangable file is changed: ${file}"
    echo "\n${RESULTS}\n"	
    ERROR=1	
done	
exit "${ERROR}"
