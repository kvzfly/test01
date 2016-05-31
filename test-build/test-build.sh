#!/bin/sh
cd ${WORKSPACE}/src
docker build -t 192.168.5.31:80/python-redis-demo:${BUILD_NUMBER} .

docker push 192.168.5.31:80/python-redis-demo:${BUILD_NUMBER}
cd ${WORKSPACE}/test-build

sed -i 's/\$\$BUILD_NUMBER\$\$/'${BUILD_NUMBER}'/g' docker-compose.yml
sed -i 's/\$\$PORT_NUMBER\$\$/'`expr 5000 + ${BUILD_NUMBER}`'/g' docker-compose.yml
chmod 777 ./rancher-compose

./rancher-compose --access-key 67D80D1F783AFD302842 --secret-key HY27yD11kxAFMQRsxgLVHeWW7zax9SrNc2Yu4W15 -p python-redis-demo-build${BUILD_NUMBER} up -d
