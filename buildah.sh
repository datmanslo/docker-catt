#!/usr/bin/env bash

set -o errexit

base_os="alpine"
base_os_version="3.12.1"
catt_version="v0.11.3"
container=$(buildah from $base_os:$base_os_version)
image_name="datmanslo/catt"

# Labels
buildah config --label maintainer="datmanslo <datmanslo@yahoo.com>" $container
buildah config --label version=$catt_version $container
buildah config --label repo="github.com/datmanslo/docker-catt" $container

buildah run $container apk add --no-cache python3 py3-pip
buildah run $container pip3 install catt==$catt_version
buildah run $container apk del --purge py3-pip
buildah run $container rm -rf /root/.cache/pip

buildah config --entrypoint catt $container

# Finally saves the running container to an image
buildah commit --format docker $container $image_name:latest
buildah tag $image_name:latest $image_name:$catt_version
