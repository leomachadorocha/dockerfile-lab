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

#### 3 - Review the two simple text files of your completed Docker project
```
$ ls -lF
```
```
total 16
-rw-r--r--  1 wkulhane  staff  1521 Oct 11 14:26 Dockerfile
-rwxr-xr-x  1 wkulhane  staff   516 Oct 11 14:25 loveLXC.sh*
```

#### 4 - While still in the busyBox_project directory, build the Docker image
```
$ docker build --rm=true -t rhtgptetraining/lovelxc .
```

#### 5 - Note the presence of your new custom Docker image
```
$ docker images
```

#### 6 - Run a new container (without passing an environment variable) from your custom image
```
$ docker run -d --name="my-lovelxc-container" rhtgptetraining/lovelxc
```

#### 7 - Tail the standard output of the container
```
$ docker logs -f my-lovelxc-container
```

#### 8 - Review the standard output and press Ctrl+C when you are finished


#### 9 - Delete the existing container and re-instantiate using an environment variable
```
$ docker rm -f my-lovelxc-container
$ docker run -d --name="my-lovelxc-container" -e NAME="The world" rhtgptetraining/lovelxc
```

#### 10 - Again, tail the standard output
```
$ docker logs -f my-lovelxc-container
```

#### 11 - Review the output of this new container and press Ctrl+C when finished   
   
   
===========================================================================================   

### Examine Mounted Volume


#### 12 - Execute the docker inspect command and retrieve the path on the host operating system to the container volume
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

#### 13 - View the contents of the file written by the script to this external volume on the host operating system
```
$ cat /var/lib/docker/volumes/3f249a116633074e34840ddea836f26a570b7ef36bcdb01cdbd22f8f37cf4705/_data/super_top_secret_log.log  | more
```
```
The world loves linux containers
The world loves linux containers
The world loves linux containers
```  

===========================================================================================   
   
   
#### 14 - Delete the running container
```
$ docker rm -f my-lovelxc-container
```
 
#### 15 - Delete the image
```
$ docker rmi rhtgptetraining/lovelxc
```

#### 16 - Delete the busybox base image
```
$ docker rmi busybox
```
