# Docker help #

## Definitions ##

* An [image](http://docs.docker.com/reference/glossary/#image) is an ordered collection of root filesystem changes and the corresponding execution parameters for use within a container runtime. Images are read-only.
 
* A [container](http://docs.docker.com/reference/glossary/#container) is an active (or inactive if exited) stateful instantiation of an image.
* Pull a docker image >> Run it interactively and make changes >> Use the corresponding container to make a new image >> push this new image to the docker hub.

* This does a great job at explaining difference between images/containers -> [SO](http://stackoverflow.com/questions/21498832/in-docker-whats-the-difference-between-a-container-and-an-image)   

## Commands ##
 
on Linux ALWAYS use "sudo", on Mac give it a miss.  
 
docker pull ubuntu 
docker run -i -t ubuntu /bin/bash - log in to the ubuntu docker image/container as root and run an interactive session. 
sudo docker run -i -t -v /home/script:/script [docker_username]/[new_docker_image_name] /bin/bash - runs an interactive docker container and mounts the /home/script folder from the host machine as the /script folder on the Docker container. This is a USEFUL for mounting local folders which might contain data scripts etc into docker.   
The docker build -t docker-whale . command takes the Dockerfile in the current directory, and builds an image called docker-whale on your local machine.  
docker logs <container_name>  
docker run -d -P training/webapp python app.py  :: -d background -P map any required network ports inside container to host 
docker ps -a  
docker tag 7d9495d03763 maryatdocker/docker-whale:latest - tag existing image with different name.  
docker rmi -f 7d9495d03763 - will only untag the image 
docker rmi -f docker-whale - will actually delete the image (for the example in http://docs.docker.com/mac/started) 
network port shortcut - docker port 
inspecting web application container - docker inspect <container_name> 
$ docker run -t -i training/sinatra /bin/bash  
root@0b2616b0e5a8:/#   <--- Here 0b2616b0e5a8 is the container ID  
Images that use the v2 or later format have a content-addressable identifier called a DIGEST 
you can use identifier for push/pull/create run/rmi/FROM 
Container names have to be unique. 
 
The docker run documentation describes how to automatically clean up the container and remove the file system when the container exits: 
--rm=false: Automatically remove the container when it exits (incompatible with -d)  
The above shows that by default containers are not removed, but adding --rm=true or just the short-hand -rm will work like so: 
sudo docker run -i -t --rm ubuntu /bin/bash  
When you exit from the container it will be automatically removed. 
 
Here is an example on how to clean up old containers that are weeks old. 
$ docker ps -a | grep 'weeks ago' | awk '{print $1}' | xargs --no-run-if-empty docker rm 
 
Similar command to remove all untagged images:  
docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi 

**docker-machine**

`docker-machine create -d virtualbox --virtualbox-memory 8192 --virtual-disksize 600000 default` - [SO](http://stackoverflow.com/questions/32834082/how-to-increase-docker-machine-memory-mac)

 
## Data sharing ##
Data volumes - docker run -d -P --name web -v /webapp training/webapp python app.py 
use docker inspect web to locate the volume on the host 
docker run -d -P --name web -v /src/webapp:/opt/webapp training/webapp python app.py will mount the host directory /src/webapp into the container /opt/webapp 
This is very useful for testing, for example we can mount our source code inside the container and see our application at work as we change the source code. The directory on the host must be specified as an absolute path and if the directory doesn’t exist Docker will automatically create it for you. 
This is not available from a Dockerfile due to the portability and sharing purpose of built images. The host directory is, by its nature, host-dependent, so a host directory specified in a Dockerfile probably wouldn’t work on all hosts. 
we can also mount a directory read-only - using :ro 
 
## Docker File ##
Avoid using your root directory, /, as the root of the source repository. The docker build command will use whatever directory contains the Dockerfile as the build context (including all of its subdirectories). This means if / is used, the entire contents of your hard drive will get sent to the daemon. 
.dockerignore  
*/temp*  
*/*/temp*  
temp?  
*.md  
!LICENCSE.md 
Note that each instruction is run independently, and causes a new image to be created - so RUN cd /tmp will not have any effect on the next instructions. 
In almost all cases, you should only run a single process in a single container.  
FROM : which base image to use this - ? - http://phusion.github.io/baseimage-docker  
a RUN instruction executes a command inside the image, for example installing a package. 
Don’t do RUN apt-get update on a single line. This will cause caching issues if the referenced archive gets updated, which will make your subsequent apt-get install fail without comment. 
Avoid RUN apt-get upgrade or dist-upgrade 
If you know there’s a particular package, foo, that needs to be updated, use apt-get install -y foo and it will update automatically. 
 In most other cases, CMD should be given an interactive shell (bash, python, perl, etc), for example, CMD ["perl", "-de0"], CMD ["python"], or CMD [“php”, “-a”].  
If your Dockerfile uses only CMD, the provided command will be run if no arguments are passed to docker run. 
The EXPOSE instruction indicates the ports on which a container will listen for connections. 
For example, an image containing the Apache web server would use EXPOSE 80, while an image containing MongoDB would use EXPOSE 27017 and so on. 
You can use ENV to update the PATH environment variable for the software your container installs. 
For example, ENV PATH /usr/local/nginx/bin:$PATH will ensure that CMD [“nginx”] just works. 
The ENV instruction is also useful for providing required environment variables specific to services you wish to containerize, such as Postgres’s PGDATA. 
COPY - If you build using STDIN (docker build - < somefile), there is no build context, so COPY can’t be used. 
http://stackoverflow.com/questions/30604846/docker-error-no-space-left-on-device - COPY fails due to file size 
 
Guess: The Dockerfile helps to programmatically create an image/container that one can upload to Docker hub. The image will reside on Docker hub (or be created on the fly ?) 
 
Once the docker image has been modified and then the container state been committed to a new image, mounts can be used to access scripts/software/datasets. 
 
**boot2docker - DEPRECATED**
* `$(boot2docker shellinit 2> /dev/null)` should be in the `.bash_profile` so that certain env. variables are set. (??? Dunno if it actually works)
* In MacOS X, `boot2docker` needs to be up before docker runs.
* kind words for docker by [Brad Chapman](http://bcb.io/2014/03/06/improving-reproducibility-and-installation-of-genomic-analysis-pipelines-with-docker)
* If using the `boot2docker` VM on OS X, Windows or Linux, you’ll need to get the IP of the virtual host instead of using localhost. You can do this by running the following outside of the `boot2docker` shell --> `$ boot2docker ip` 
 
## Links ##
 
Digital ocean's summaries: 
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-getting-started 
https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images 
https://www.digitalocean.com/community/tutorials/the-docker-ecosystem-an-overview-of-containerization 
 
http://crosbymichael.com/dockerfile-deep-dive.html  
http://crosbymichael.com/dockerfile-best-practices.html 
http://crosbymichael.com/dockerfile-best-practices-take-2.html 
http://crosbymichael.com/creating-containers-part-1.html  
 
https://docs.docker.com/docker-hub/builds  
https://docs.docker.com/project/test-and-docs  
https://www.binarysludge.com/2015/01/07/talk-building-and-testing-docker-containers  
 
https://docs.docker.com/reference/builder 
http://docs.docker.com/articles/dockerfile_best-practices  
http://www.projectatomic.io/docs/docker-image-author-guidance  
https://coderwall.com/p/4g8znw/things-i-learned-while-writing-a-dockerfile  
 
http://docs.docker.com/userguide 
http://docs.docker.com/compose 
https://docs.docker.com/reference/commandline/cli 
 
http://stackoverflow.com/questions/17236796/how-to-remove-old-docker-containers  
http://stackoverflow.com/questions/25101596/docker-interactive-mode-and-executing-script  
http://stackoverflow.com/questions/25490911/how-do-you-add-items-to-dockerignore  
http://stackoverflow.com/questions/21553353/what-is-the-difference-between-cmd-and-entrypoint-in-a-dockerfile  
http://stackoverflow.com/questions/21498832/in-docker-whats-the-difference-between-a-container-and-an-image  
http://stackoverflow.com/questions/24309526/how-to-change-the-docker-image-installation-directory  
http://stackoverflow.com/questions/22967806/where-are-docker-images-stored-by-boot2docker  
http://stackoverflow.com/questions/30604846/docker-error-no-space-left-on-device  
