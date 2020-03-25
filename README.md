# simpleWebApp
simpleWebApp - simple web application with Gin framework written on Golang and running in Docker

- Golang 1.14 
- Gin v1.6.0
- Docker Alpine latest

Build docker image: 
> docker build -t junoteam/simplewebapp .

Run docker container: 
> docker container run -ti --name simpleWebGoApp --rm -p 8080:8080 junoteam/simplewebapp:latest

Check results:  

![](https://github.com/junoteam/simpleWebApp/blob/master/simpleWebApp.png)
