docker build -t qingcai/multi-client:latest -t qingcai/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t qingcai/multi-server:latest -t qingcai/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t qingcai/multi-worker:latest -t qingcai/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push qingcai/multi-client:latest
docker push qingcai/multi-server:latest
docker push qingcai/multi-worker:latest

docker push qingcai/multi-client:$SHA
docker push qingcai/multi-server:$SHA
docker push qingcai/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=qingcai/multi-server:$SHA
kubectl set image deployments/client-deployment client=qingcai/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=qingcai/multi-worker:$SHA