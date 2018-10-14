#!/bin/sh

# stop if anything exits with an error
set -e

base_dir=$(dirname $0)

echo "Updating version"
${base_dir}/steps/rewrite_version.sh

echo "Building new docker version"
${base_dir}/steps/build_docker.sh

echo "Pushing to Docker"
${base_dir}/steps/push_production.sh ${DOCKER_USER} ${DOCKER_PASSWORD}

echo "Running the website in production"
${base_dir}/steps/run_production.sh ${DEPLOY_USER} ${DEPLOY_SERVER}
