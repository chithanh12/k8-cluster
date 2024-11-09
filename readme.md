# Install minikube


# Install argo-cd
Run the following commands to install argocd:
```
## Create a new namespace for argocd
$ kubectl create ns argo-cd

## Add argocd-helm to helm repo & update repository
$ helm repo add argo-cd https://argoproj.github.io/argo-helm
$ helm dep update argo-cd/

## Install to k8s
$ helm install argo-cd argo-cd/ -f argo-cd/values.yaml -n argo-cd

## Get admin password
$ kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" -nargo-cd | base64 -d

## Forward port of argocd server to host and access web UI
$ kubectl port-forward svc/argo-cd-argocd-server 8080:443 -nargo-cd

```
# Install Kong
Run the following commands to install kong:

```
## Create a new namespace ingress for Kong
$ kubectl create namespace ingress

## Update helm dependency
$ helm dep update kong/

## Install
$ helm install kong kong/ -f kong/values.yaml -ningress

```
Then you can export Kong proxy to your host to test your service by using the following command:
```
$ minikube service -n ingress kong-proxy --url | head -1
```

The output is similar this:
```
[0] % minikube service -n ingress kong-proxy --url | head -1
http://127.0.0.1:64191
❗  Because you are using a Docker driver on darwin, the terminal needs to be open to run it.
```

| Note: Remember the ouput port, then we will use it later.


# Install it

- Start minikube
- Install helm
- Install 
