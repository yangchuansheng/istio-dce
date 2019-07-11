#!/bin/bash

#dceHostIp='dce-uat.boe.com.cn'
#dceHostIp='192.168.2.26'

#accessKey='rahvj2cb'
#secretKey='26mows63scz275gmq5xwfzv77pcf34bohd4ojnln'


#appName='istio-demo'
nameSpace='istio-system'

#gateway_Hostname='dce006'

echo -e "\033[32m===============开始部署 Istio===============\033[0m"
read -p "$(echo -e "\033[31m请选择运行ingressgateway的节点主机名(kubectl get node 的 NAME 字段)：\033[0m")" gateway_Hostname
kubectl create ns istio-system
kubectl apply -f istio-init.yaml
sleep 6
sed "s/GATEWAY_HOSTNAME/$gateway_Hostname/g" istio-dce.yaml|kubectl apply -f -
sleep 3

create_app(){
#在etcd中创建一个关于应用的key

cat   > /tmp/create-app  <<  EOF
curl -u ACCESSKEY:SECRETKEY -X POST -H "x-dce-tenant: NAME_SAPCE" -H "Content-Type: application/json" -d '{
    "kind": "App",
    "spec": {
        "links": [],
        "selector": {
            "matchLabels": {
                "dce.daocloud.io/app": "APP_NAME"
            }
        }
    },
    "apiVersion": "v1",
    "metadata": {
        "namespace": "NAME_SAPCE",
        "name": "APP_NAME"
    }
}' "http://${dceMasterIp}/dce/v1/apps"
EOF

sed -i "s/APP_NAME/${appName}/g" /tmp/create-app
sed -i "s/NAME_SAPCE/${nameSpace}/g" /tmp/create-app
sed -i "s/ACCESSKEY/${accessKey}/g" /tmp/create-app
sed -i "s/SECRETKEY/${secretKey}/g" /tmp/create-app

bash /tmp/create-app
}

echo -e "\033[32m===============开始创建APP===============\033[0m"
read -p "$(echo -e "\033[31m请输入 DCE 控制节点的 IP：\033[0m")" dceMasterIp
read -p "$(echo -e "\033[31m请输入 DCE 访问 ACCESS KEY：\033[0m")" accessKey
read -p "$(echo -e "\033[31m请输入 DCE 访问 SECRET KEY：\033[0m")" secretKey
read -p "$(echo -e "\033[31m请输入准备创建的应用名：\033[0m")" appName
create_app
if [ $? -eq 0 ]; then
  echo -e "\033[32m===============APP创建成功===============\033[0m"
fi


sed "s/APPNAME/${appName}/g" ./patch-deployment.yaml > /tmp/patch-deployment.yaml
sed "s/APPNAME/${appName}/g" ./patch-svc.yaml > /tmp/patch-svc.yaml

deployList=$(kubectl -n istio-system get deploy|egrep -v NAME|awk '{print $1}')
serviceList=$(kubectl -n istio-system get svc|egrep -v NAME|awk '{print $1}')
echo -e "\033[32m===============开始更新Deployment===============\033[0m"
for i in $deployList; do
kubectl -n istio-system patch deploy $i --patch  "$(cat /tmp/patch-deployment.yaml)"
done

echo -e "\033[32m===============开始更新Service===============\033[0m"
for i in $serviceList; do
kubectl -n istio-system patch service $i --patch "$(cat /tmp/patch-svc.yaml)"
done
