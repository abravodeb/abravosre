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
[click acá](url)

o click directamente en la imagen  

url de la imagen  

## Validacion y funcionamiento de la app

``` 
❯ k get all
NAME                            READY   STATUS    RESTARTS       AGE
pod/api-84c644846f-mx2dj        1/1     Running   1 (4h5m ago)   37h
pod/db-76b9688787-n55ng         1/1     Running   1 (4h5m ago)   37h
pod/listener-7fc8675d8f-jbp5q   1/1     Running   2 (4h4m ago)   37h
pod/rabbitmq-7f66f5c6f8-cfljw   1/1     Running   1 (4h5m ago)   37h

NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/api          ClusterIP   10.96.120.49   <none>        8000/TCP   37h
service/db           ClusterIP   10.96.66.86    <none>        5432/TCP   37h
service/kubernetes   ClusterIP   10.96.0.1      <none>        443/TCP    37h
service/rabbitmq     ClusterIP   10.96.22.114   <none>        5672/TCP   37h

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/api        1/1     1            1           37h
deployment.apps/db         1/1     1            1           37h
deployment.apps/listener   1/1     1            1           37h
deployment.apps/rabbitmq   1/1     1            1           37h

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/api-84c644846f        1         1         1       37h
replicaset.apps/db-76b9688787         1         1         1       37h
replicaset.apps/listener-7fc8675d8f   1         1         1       37h
replicaset.apps/rabbitmq-7f66f5c6f8   1         1         1       37h


❯ k  logs pod/listener-7fc8675d8f-jbp5q
creando las tablas
 [*] Waiting for messages. To exit press CTRL+C

```


## Visualizacion y Monitoreo

Para visualizar el monitoreo del servicio las credenciales fueron enviadas al correo + direccion IP

Servicios utilizados:

* Grafana 
* Prometheus + node_exporter 


