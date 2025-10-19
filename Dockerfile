ARG BASE_OS="alpine"
ARG BASE_OS_VERSION="3.22"

FROM ${BASE_OS}:${BASE_OS_VERSION}

ARG CATT_VERSION=0.13.0
ENV CATT_VERSION=${CATT_VERSION}

LABEL maintainer="datmanslo@yahoo.com" \
    version="${CATT_VERSION}" \
    repo="github.com/datmanslo/docker-catt"

RUN apk add --no-cache python3 py3-pip && \
    pip3 install --no-cache-dir --break-system-packages catt==${CATT_VERSION} && \
    find /usr/lib/python3* -name '__pycache__' -type d -exec rm -rf {} + 2>/dev/null || true && \
    rm -rf /root/.cache

ENTRYPOINT ["catt"]
