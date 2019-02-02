docker build -t sdrpaladu/multi-client:latest -t sdrpaladu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sdrpaladu/multi-server:latest -t sdrpaladu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sdrpaladu/multi-worker:latest -t sdrpaladu/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sdrpaladu/multi-client:latest
docker push sdrpaladu/multi-client:$SHA
docker push sdrpaladu/multi-server:latest
docker push sdrpaladu/multi-server:$SHA
docker push sdrpaladu/multi-worker:latest
docker push sdrpaladu/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sdrpaladu/multi-server:$SHA
kubectl set image deployments/client-deployment client=sdrpaladu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sdrpaladu/multi-worker:$SHA
