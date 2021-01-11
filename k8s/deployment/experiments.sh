k apply -f https://raw.githubusercontent.com/Piotr1215/dca-exercises/master/k8s/deployment/1-create-deployment.yaml

k scale deployment nginx-test --replicas 5

k expose deployment.app/nginx-test --port 80 --target-port 80 --type NodePort --name nginxsvc

k set image deployment/nginx-test nginx-test=piotrzan/nginx-demo:blue --record