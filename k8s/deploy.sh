docker build -t dibyajyoti47/multi-client:latest -t dibyajyoti47/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t dibyajyoti47/multi-server:latest -t dibyajyoti47/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dibyajyoti47/multi-worker:latest -t dibyajyoti47/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dibyajyoti47/multi-client:latest
docker push dibyajyoti47/multi-server:latest
docker push dibyajyoti47/multi-worker:latest
docker push dibyajyoti47/multi-client:$SHA
docker push dibyajyoti47/multi-server:$SHA
docker push dibyajyoti47/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server-deployment server=dibyajyoti47/multi-server:$SHA
kubectl set image deployments/client-deployment client-deployment client=dibyajyoti47/multi-client:$SHA
kubectl set image deployments/worker-deployment worker-deployment worker=dibyajyoti47/multi-worker:$SHA