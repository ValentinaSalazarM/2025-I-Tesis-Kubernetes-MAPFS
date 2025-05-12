$tag = "latest"

Write-Host "Construyendo imágenes Docker"
docker build -t mapfs-cloud:$tag -f ./IoT/cloud/MAPFS/Dockerfile ./IoT
docker build -t mapfs-gateway:$tag -f ./IoT/gateway/MAPFS/Dockerfile ./IoT
docker build -t mapfs-device:$tag -f ./IoT/device/MAPFS/Dockerfile ./IoT
docker build -t mapfs-locust-image:$tag -f ./attacks/Dockerfile.locust ./attacks
docker build -t sniffer-capture:latest -f attacks/Dockerfile.capture ./attacks
docker build -t sniffer-replicate:latest -f attacks/Dockerfile.replicate ./attacks

Write-Host "Cargando imágenes en Minikube"
minikube image load mapfs-cloud:$tag
minikube image load mapfs-gateway:$tag
minikube image load mapfs-device:$tag
minikube image load mapfs-locust-image:$tag
minikube image load sniffer-capture:latest
minikube image load sniffer-replicate:latest

Write-Host "Aplicando manifiestos con Kustomize"
kubectl apply -k .
