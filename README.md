# simpleWebApp
simpleWebApp - simple web application with Gin framework written on Golang and running in Docker

- Golang 1.14 
- Gin v1.6.0
- Docker Alpine latest
- Kubernetes v1.18.0

Build docker image: 
> docker build -t mothes/simplewebapp .

Push to dockerhub: 
> docker push mothes/simplewebapp

Run docker container: 
> docker container run -ti --name simpleWebGoApp --rm -p 8080:8080 mothes/simplewebapp

Check results:  
![](https://github.com/junoteam/simpleWebApp/blob/master/simpleWebApp.png)

Run app in Kubernetes: 
> kubectl apply -f kubernetes/simpleWebApp.yml

Check status of deployment in Kubernetes:
``` 
kubectl get deployments,svc,pods -l app=simple-web-app -o wide
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS       IMAGES                SELECTOR
deployment.apps/simple-web-app   1/1     1            1           2m30s   simple-web-app   mothes/simplewebapp   app=simple-web-app

NAME                         TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE     SELECTOR
service/simple-web-app-svc   NodePort   10.152.183.130   <none>        8080:30482/TCP   2m30s   app=simple-web-app

NAME                                READY   STATUS    RESTARTS   AGE     IP          NODE         NOMINATED NODE   READINESS GATES
pod/simple-web-app-c689f87b-gk8qx   1/1     Running   0          2m30s   10.1.99.9   homeserver   <none>           <none>
```

Check whas is your endpoint to Kube and test it: 
```
curl http://10.100.102.5:30482/ping
{"message":"pong"}
```