# simpleWebApp
**simpleWebApp** - simple web application with Gin framework written on Golang and running in Docker

- Golang 1.14 
- Gin v1.6.0
- Docker Alpine latest
- Kubernetes v1.18.0

Build docker image:   
`docker build -t mothes/simplewebapp .`

Login to Dockerhub: 
`docker login`

Push to dockerhub:  
`docker push mothes/simplewebapp`

Run docker container:   
`docker container run -ti --name simpleWebGoApp --rm -p 8080:8080 mothes/simplewebapp`

Check results:  
![](https://github.com/junoteam/simpleWebApp/blob/master/simpleWebApp.png)

Run app in Kubernetes:  
`kubectl apply -f kubernetes/simpleWebApp.yml`

p.s.: Don't forget to add secrets from private docker registry to Kubernetes

Check you Docker config:
`cat ~/.docker/config.json`

Add secret to Kubernetes:
```
kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=/root/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson
```

Check status of deployment in Kubernetes:
``` 
kubectl get deployments,svc,pods -l app=simple-web-app -o wide
NAME                             READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS       IMAGES                SELECTOR
deployment.apps/simple-web-app   3/3     3            3           17h   simple-web-app   mothes/simplewebapp   app=simple-web-app

NAME                         TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE   SELECTOR
service/simple-web-app-svc   NodePort   10.152.183.130   <none>        8080:30482/TCP   17h   app=simple-web-app,color=blue

NAME                                  READY   STATUS    RESTARTS   AGE   IP           NODE         NOMINATED NODE   READINESS GATES
pod/simple-web-app-8568875847-6j6tz   1/1     Running   1          10h   10.1.99.27   homeserver   <none>           <none>
pod/simple-web-app-8568875847-whdsz   1/1     Running   2          10h   10.1.99.29   homeserver   <none>           <none>
pod/simple-web-app-8568875847-z2tmb   1/1     Running   2          10h   10.1.99.30   homeserver   <none>           <none>
```

Check what's your endpoint in Kubernetes and test it: 
```
curl http://10.100.102.5:30482/ping
{"message":"pong"}
```

HPA. Horizontal Pod Autoscaler.
```
kubectl describe hpa simple-web-app
Name:                                                  simple-web-app
Namespace:                                             default
Labels:                                                <none>
Annotations:                                           CreationTimestamp:  Sun, 05 Apr 2020 17:59:27 +0300
Reference:                                             Deployment/simple-web-app
Metrics:                                               ( current / target )
  resource memory on pods:                             3043328 / 100Mi
  resource cpu on pods  (as a percentage of request):  1% (1m) / 20%
Min replicas:                                          1
Max replicas:                                          8
Deployment pods:                                       1 current / 1 desired
Conditions:
  Type            Status  Reason              Message
  ----            ------  ------              -------
  AbleToScale     True    ReadyForNewScale    recommended size matches current size
  ScalingActive   True    ValidMetricFound    the HPA was able to successfully calculate a replica count from memory resource
  ScalingLimited  False   DesiredWithinRange  the desired count is within the acceptable range
Events:           <none>
```

---

*Roadmap:* 
- HPA manifest for autoscaling pods in Kubernetes ✔
- Helm3 chart for app 
- Blue/Green deployments
- Automaical tests (In Travis)
- External Load Balancer (for Blue/Green) deployments
- Install Jenkins on top of Kubernetes
- Migrate local Kubernetes setup, to GKE ✔
- Describe how to install HA Kubernetes cluster in AWS Amazon.
- Create Nginx (Contour) Ingress controller as point of traffic for Jenkins
- Configure Nginx (Contour) Ingress controller to use TLS + Basic Auth
- Create deployment in Jenkins + Deploy