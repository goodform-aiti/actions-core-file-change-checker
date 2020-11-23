#!/bin/sh
set -e
ERROR=0
echo "11111xxxx"
CHANGED_FILES=$(git diff --name-only --diff-filter=AM ${PREVIOUS_COMMIT} ${CURRENT_COMMIT})

echo "22222"
CHANGED_FILES_PHP=$(find ${CHANGED_FILES} -type f -regex "^.*\(\.php\|\.phtml\)$")

echo "333333"
CHANGED_CORE_FILES=$(find ${CHANGED_FILES} -type f -regex "^\(app/code/core\|app/design/frontend/base\|app/design/adminhtml/base\)/.+$")

echo ${CHANGED_CORE_FILES}
for file in ${CHANGED_CORE_FILES}; do		


    echo "5555"
    RESULTS="Unchangable file is changed: ${file}"
    echo "\n${RESULTS}\n"	
    ERROR=1	
    echo "6666"
done	
exit "${ERROR}"
