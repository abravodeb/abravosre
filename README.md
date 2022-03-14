# Prueba SRE/Devops

## Introducción

Se utilizará como cloud provider AWS, con una instancia de ec2 (VM) desplegando con Terraform y aprovisionada con Ansible  

Estructura de directorios.  

``` 
Folders: 

terraform --> deployment/vm_core.tf  
ansible   --> provision/vm_core.yaml, node_exporter.yaml, monitoring.yaml  
k8s       --> manifiestos Kubernetes para desplegar la app en servidor 

```

## Detalles técnicos

Ambiente de pruebas para ejecutar kubernetes se usa "kind" Kubernetes in Docker  
El archivo docker-compose que fue proporcionado se convirtió a manifiestos de kubernetes utilizando "kompose" realizando modificaciones
para el correcto funcionamiento, las imagen "api y listener" se realizó un push a dockerhub que son utilizadas en los deployment.  


## Secuencia en asciinema

Para visualizar el proceso de despligue y funcionamiento por favor revisar link adjunto.  

[click acá](https://asciinema.org/a/Rie6gVq2VCb14b98VE1ooE2gh)

o click directamente en la imagen  

[![asciicast](https://asciinema.org/a/14.png)](https://asciinema.org/a/Rie6gVq2VCb14b98VE1ooE2gh)

## Validacion y funcionamiento de la app

``` 
[ec2-user@ip-172-31-85-191 ~]$ curl localhost:8000


{"message":"Hello World!"}

[ec2-user@ip-172-31-85-191 ~]$ kubectl get all
NAME                            READY   STATUS    RESTARTS   AGE
pod/api-66c666d495-tx6w2        1/1     Running   0          8m34s
pod/db-64b4b4f757-8wv2k         1/1     Running   0          8m34s
pod/listener-787784f675-ksxkk   1/1     Running   0          8m34s
pod/rabbitmq-64574d65fb-br5vt   1/1     Running   0          8m34s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/api          ClusterIP   10.96.157.205   <none>        8000/TCP   8m34s
service/db           ClusterIP   10.96.223.89    <none>        5432/TCP   8m34s
service/kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP    9m52s
service/rabbitmq     ClusterIP   10.96.12.163    <none>        5672/TCP   8m34s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/api        1/1     1            1           8m34s
deployment.apps/db         1/1     1            1           8m34s
deployment.apps/listener   1/1     1            1           8m34s
deployment.apps/rabbitmq   1/1     1            1           8m34s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/api-66c666d495        1         1         1       8m34s
replicaset.apps/db-64b4b4f757         1         1         1       8m34s
replicaset.apps/listener-787784f675   1         1         1       8m34s
replicaset.apps/rabbitmq-64574d65fb   1         1         1       8m34s

[ec2-user@ip-172-31-85-191 ~]$ kubectl logs pod/listener-787784f675-ksxkk
creando las tablas
 [*] Waiting for messages. To exit press CTRL+C
 [x] Received b'Hello World!'
ejecutando tarea pesada
tarea lista
 [x] Received b'Hello World!'
ejecutando tarea pesada
tarea lista
 [x] Received b'Hello World!'
ejecutando tarea pesada
tarea lista


```


## Visualizacion y Monitoreo

Para visualizar el monitoreo del servicio las credenciales fueron enviadas al correo + direccion IP

Servicios utilizados:

* Grafana 
* Prometheus + node_exporter 


