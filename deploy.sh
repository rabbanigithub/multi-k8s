docker build -t rabbanidocker/multi-client:latest -t rabbanidocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rabbanidocker/multi-server:latest -t rabbanidocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rabbanidocker/multi-worker:latest -t rabbanidocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rabbanidocker/multi-client:latest
docker push rabbanidocker/multi-server:latest
docker push rabbanidocker/multi-worker:latest

docker push rabbanidocker/multi-client:$SHA
docker push rabbanidocker/multi-server:$SHA
docker push rabbanidocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rabbanidocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=rabbanidocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rabbanidocker/multi-worker:$SHA
