#!/bin/sh
set -e
ERROR=0
CHANGED_FILES=$(git diff --name-only --diff-filter=AM master)
CHANGED_FILES_PHP=$(find ${CHANGED_FILES} -type f -regex "^.*\(\.php\|\.phtml\)$")
CHANGED_CORE_FILES=$(find ${CHANGED_FILES} -type f -regex "^\(app/code/core\|app/design/frontend/base\|app/design/adminhtml/base\|app/code/community\)/.+$")

for file in ${CHANGED_CORE_FILES}; do		
    RESULTS="Unchangable file is changed: ${file}"
    echo "\n${RESULTS}\n"	
    ERROR=1	
done	
exit "${ERROR}"
