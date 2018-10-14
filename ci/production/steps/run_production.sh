#!/bin/sh

# lets copy over our compose incase of any changes
scp -o "StrictHostKeyChecking no" docker-compose.production.yml ${1}@${2}:/${1}/lk_website
ssh -o "StrictHostKeyChecking no" ${1}@${2} "cd lk_website; docker-compose -f docker-compose.production.yml pull; docker-compose -f docker-compose.production.yml up -d --build web"
