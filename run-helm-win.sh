#!/usr/bin/bash
ns="-n web-app"

echo "my-php-web-app.com"
read -p "Enter the desired hostname for your app: " MYHOST

echo -e "\n ------ Launch Ingress ------ \n"
minikube addons enable ingress
sleep 10

echo -e "\n ------ Install Helm ------ \n"

helm install webappchik /c/MyDesktop/Myapp/helm-chart-1/myHelm

echo -e "\n ------ Waiting for an IP address ------\n"
kubectl get ingress $ns
sleep 40
kubectl get ingress $ns

IP=$(kubectl get ingress -n web-app php-app-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo -e "\n ------ Starting tests ------ \n"
#ip resolving
echo "$IP $MYHOST"

#checking connection
for i in version1 version2; do curl my-php-web-app.com/$i; done