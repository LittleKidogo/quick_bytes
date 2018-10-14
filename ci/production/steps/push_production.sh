#!/bin/sh
docker login -u ${1} -p ${2}
docker tag lk-site:latest littlekidogo/lk-site:latest
docker push littlekidogo/lk-site:latest
