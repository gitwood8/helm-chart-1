#!/usr/bin/bash
ns="-n web-app"
echo "my-php-web-app.com"
read -p "Enter the desired hostname for your app: " MYHOST

kubectl apply -f php-deploy-v1.yml
kubectl apply -f php-deploy-v2.yml

echo -e "\n Apply Deployments in progress \n"

sleep 15

echo -e "\n Launch Ingress \n"
minikube addons enable ingress

echo -e "\n Applying nginx ingress \n"
kubectl apply -f php-ingress.yml
sleep 15
kubectl get ingress $ns

IP=$(kubectl get ingress -n web-app php-app-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo -e "\n Print test \n"
echo "$MYHOST"
echo "$IP"
sleep 60
#ip resolving
echo "$IP $MYHOST" | sudo tee -a /etc/hosts
cat /etc/hosts
#checking connection
echo -e "\n Starting tests \n"
for i in version1 version2; do curl my-php-web-app.com/$i; done