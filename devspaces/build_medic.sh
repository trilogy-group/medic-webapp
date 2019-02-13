#!/bin/bash

echo "*** Settingup couchdb ***"
curl -X PUT http://admin:pass@localhost:5984/_users
curl -X PUT http://admin:pass@localhost:5984/_replicator
curl -X PUT http://admin:pass@localhost:5984/_global_changes
curl -X PUT http://admin:pass@localhost:5986/_config/chttpd/require_valid_user -d '"true"' -H "Content-Type: application/json"
curl -X PUT http://admin:pass@localhost:5986/_config/httpd/WWW-Authenticate -d '"Basic realm=\"administrator\""' -H "Content-Type: application/json"
curl -X PUT --data '"4294967296"' http://admin:pass@localhost:5986/_config/httpd/max_http_request_size
echo "*** couchdb setup complete ***"
cd /data
echo "*** Starting Installation of medic ***"
yarn install
rm -f .env
echo `COUCH_URL=${COUCH_URL}` > .env
echo `COUCH_NODE_NAME=${COUCH_NODE_NAME}` >> .env
cat .env

pushd webapp
yarn install
popd

pushd admin
yarn install
popd

pushd api
yarn install
popd

pushd sentinel
yarn install
popd

echo "*** starting grunt ***"
grunt build-dev
grunt deploy
grunt dev-api