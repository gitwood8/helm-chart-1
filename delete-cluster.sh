#!/usr/bin/bash
kubectl delete -f php-deploy-v1.yml
kubectl delete -f php-deploy-v2.yml
kubectl delete -f php-ingress.yml
minikube addons disable ingress