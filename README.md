# helm-chart-1


I got errors like:

Error from server (InternalError): error when creating "php-ingress.yml": Internal error occurred: failed calling webhook "validate.nginx.ingress.kubernetes.io": failed to call webhook: Post "https://ingress-nginx-controller-admission.ingress-nginx.svc:443/networking/v1/ingresses?timeout=10s": dial tcp --------: connect: connection refused

Solved: waiting for 10 sec and reapply ingress.yml. Then i need 40 seconds to get en external IP. In the end i have some healthchecks (will be deleted). Check out run.sh