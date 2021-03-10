docker build -t stephengrider/multi-client:latest -t stephengrider/multi-client:latest$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-worker:latest -t stephengrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t cygnetops/multi-server-pgfix-5-11:latest -t cygnetops/multi-server-pgfix-5-11:$SHA -f ./server/Dockerfile ./server

docker push cygnetops/multi-server-pgfix-5-11:latest
docker push stephengrider/multi-client:latest
docker push stephengrider/multi-worker:latest

docker push cygnetops/multi-server-pgfix-5-11:$SHA
docker push stephengrider/multi-client:$SHA
docker push stephengrider/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=cygnetops/multi-server-pgfix-5-11:$SHA
kubectl set image deployments/client-deployments client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=stephengrider/multi-worker:$SHA
