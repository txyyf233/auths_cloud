#!/bin/sh

# 复制项目的文件到对应docker路径，便于一键生成镜像。
usage() {
	echo "Usage: sh copy.sh"
	exit 1
}


# copy sql
echo "begin copy sql "
cp ../sql/ry_20230223.sql ./mysql/db
cp ../sql/ry_config_20220929.sql ./mysql/db

# copy html
echo "begin copy html "
cp -r ../auths-ui/dist/** ./nginx/html/dist


# copy jar
echo "begin copy auths-gateway "
cp ../auths-gateway/target/auths-gateway.jar ./auths/gateway/jar

echo "begin copy auths-auth "
cp ../auths-auth/target/auths-auth.jar ./auths/auth/jar

echo "begin copy auths-visual "
cp ../auths-visual/auths-monitor/target/auths-visual-monitor.jar  ./auths/visual/monitor/jar

echo "begin copy auths-modules-system "
cp ../auths-modules/auths-system/target/auths-modules-system.jar ./auths/modules/system/jar

echo "begin copy auths-modules-file "
cp ../auths-modules/auths-file/target/auths-modules-file.jar ./auths/modules/file/jar

echo "begin copy auths-modules-job "
cp ../auths-modules/auths-job/target/auths-modules-job.jar ./auths/modules/job/jar

echo "begin copy auths-modules-gen "
cp ../auths-modules/auths-gen/target/auths-modules-gen.jar ./auths/modules/gen/jar

