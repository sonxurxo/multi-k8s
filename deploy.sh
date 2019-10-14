docker build -t sonxurxo/multi-client:latest -t sonxurxo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sonxurxo/multi-server:latest -t sonxurxo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sonxurxo/multi-worker:latest -t sonxurxo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sonxurxo/multi-client:latest
docker push sonxurxo/multi-server:latest
docker push sonxurxo/multi-worker:latest
docker push sonxurxo/multi-client:$SHA
docker push sonxurxo/multi-server:$SHA
docker push sonxurxo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sonxurxo/multi-server:$SHA
kubectl set image deployments/client-deployment client=sonxurxo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sonxurxo/multi-worker:$SHA