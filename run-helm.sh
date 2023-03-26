#!/usr/bin/bash
ns="-n web-app"

echo "my-php-web-app.com"
read -p "Enter the desired hostname for your app: " MYHOST

kubectl apply -f php-deploy-v1.yml
kubectl apply -f php-deploy-v2.yml 

echo -e "\n ------ Apply Deployments in progress ------ \n"
sleep 10

echo -e "\n ------ Launch Ingress ------ \n"
minikube addons enable ingress
sleep 10

echo -e "\n ------ Apply nginx ingress ------ \n"
kubectl apply -f php-ingress.yml
sleep 10
kubectl apply -f php-ingress.yml

echo -e "\n ------ ingress status check ------\n"
kubectl get ingress $ns

echo -e "\n ------ Waiting for an IP address ------\n"
sleep 40
kubectl get ingress $ns

IP=$(kubectl get ingress -n web-app php-app-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo -e "\n ------ Starting tests ------ \n"
#ip resolving
echo "$IP $MYHOST" | sudo tee -a /etc/hosts

#checking connection
for i in version1 version2; do curl my-php-web-app.com/$i; done