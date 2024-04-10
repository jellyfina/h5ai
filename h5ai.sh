#!/bin/bash
red='\033[0;31m'
plain='\033[0m'

echo -e "\033[32m正在下载H5ai,请稍后\033[0m"

cd /www

wget https://raw.650070.xyz/jellyfina/h5ai/main/h5ai.zip
echo
echo -e "\033[32mH5ai下载完成,正在解压文件\033[0m"
unzip -q h5ai.zip
echo
rm -rf h5ai.zip index.html &>/dev/null
echo -e "\033[32m开始设置文件夹权限。\033[0m"
chmod -R 777 /www/_h5ai/private/cache/

chmod -R 777 /www/_h5ai/public/cache/
echo
echo -e "\033[32m==================================================================\033[0m"
echo -e "\033[32mH5ai部署完成\033[0m"
echo -e "\033[32m==================================================================\033[0m"
echo " Alpine Linux : $(cat /etc/alpine-release)"
echo " Kernel Version : $(uname -r)"
echo " Linux Architecture : $(uname -m)"
echo " Apache Version : $(httpd -v)"
echo " Docker Hostname : $(uname -n)"
echo " Server IP : $(curl -s www.bt.cn/Api/getIpAddress)"
echo -e "\033[32m==================================================================\033[0m"
echo ""
