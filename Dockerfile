FROM php:7.4-cli

LABEL version="7.4"
LABEL repository="https://github.com/ateli-development/actions-core-file-change-checker"
LABEL homepage="https://github.com/ateli-development/actions-core-file-change-checker"
LABEL maintainer="Amir Alian <amir@ateli.cz>"

COPY "entrypoint.sh" "/entrypoint.sh"

RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
