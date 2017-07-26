# dockerfile-lab
Lab de Dockerfile do curso Application Development with Red Hat OpenShift


#### 1 - Clone the repository
```
git clone https://github.com/leomachadorocha/dockerfile-lab.git
```

#### 2 - Make the shell script executable
```
$ chmod 755 loveLXC.sh
```

#### 3 - While still in the project directory, build the Docker image
```
$ docker build --rm=true -t demorepo/lovelxc .
```

#### 4 - Note the presence of your new custom Docker image
```
$ docker images
```

#### 5 - Run a new container (without passing an environment variable) from your custom image
```
$ docker run -d --name="my-lovelxc-container" demorepo/lovelxc
```

#### 6 - Tail the standard output of the container
```
$ docker logs -f my-lovelxc-container
```

#### 7 - Review the standard output and press Ctrl+C when you are finished


#### 8 - Delete the existing container and re-instantiate using an environment variable
```
$ docker rm -f my-lovelxc-container
$ docker run -d --name="my-lovelxc-container" -e NAME="The world" demorepo/lovelxc
```

#### 9 - Again, tail the standard output
```
$ docker logs -f my-lovelxc-container
```

#### 10 - Review the output of this new container and press Ctrl+C when finished   
   
   
===========================================================================================   

### Examine Mounted Volume


#### 11 - Execute the docker inspect command and retrieve the path on the host operating system to the container volume
```
$ docker inspect -f '{{json .Mounts}}' my-lovelxc-container | jq
```
```
[
    {
        "Destination": "/var/lovelxc",
        "Driver": "local",
        "Mode": "",
        "Name": "3f249a116633074e34840ddea836f26a570b7ef36bcdb01cdbd22f8f37cf4705",
        "Propagation": "",
        "RW": true,
        "Source": "/var/lib/docker/volumes/3f249a116633074e34840ddea836f26a570b7ef36bcdb01cdbd22f8f37cf4705/_data"
    }
]
```

#### 12 - View the contents of the file written by the script to this external volume on the host operating system
```
$ cat /var/lib/docker/volumes/3f249a116633074e34840ddea836f26a570b7ef36bcdb01cdbd22f8f37cf4705/_data/super_top_secret_log.log  | more
```
```
The world loves linux containers
The world loves linux containers
The world loves linux containers
```  

===========================================================================================   
   
   
#### 13 - Delete the running container
```
$ docker rm -f my-lovelxc-container
```
 
#### 14 - Delete the image
```
$ docker rmi demorepo/lovelxc
```

#### 15 - Delete the busybox base image
```
$ docker rmi busybox
```
