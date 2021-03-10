docker build -t tubulor/multi-client:latest -t tubulor/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tubulor/multi-server:latest -t tubulor/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tubulor/multi-worker:latest -t tubulor/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tubulor/multi-client:latest
docker push tubulor/multi-server:latest
docker push tubulor/multi-worker:latest

docker push tubulor/multi-client:$SHA
docker push tubulor/multi-server:$SHA
docker push tubulor/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tubulor/multi-server:$SHA
kubectl set image deployments/client-deployment client=tubulor/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tubulor/multi-worker:$SHA