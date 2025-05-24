# Introduction:
- We will seeing:
	- Containers, Docker, Docker Compose, Images, Storage, Network, Docker Swarm, Docker Stack, Kubernetes

- What is a container?
	- The easy method to bundle an application with its requirements as efficient as possible and use it anywhere.
		- But virtual machines do this? why then use containers instead of virtual machines?
		- Virtualization is an old concept.
	- If I can take just applications and dependencies and seperate them from the operating system I would make my machine much lighter than a full VM.
	- OS:
		- User Mode and Kernel Mode
			- Bear in mind that I don't need the user mode in the container and need just the kernel mode.
			- I already have the Kernel mode in my host machine. Can I use it? 
			- Instead of using a new kernel I would just share the host's with all the containers. 
			- The Container is a virtual machine depends on the kernel of the host machine. 
![alt text](image.png)
- differential virtual hard disk it basically inherits from a VHD and stores only the changes in it thus it's lighter by alot.
- The layers' of a container:
	![alt text](image-1.png)
- Any layer can be regarded as differecing file. VHD differential...
- Container to image -> build. image to container -> pull + create
- Control groups and namespaces in linux: cgroups
	- it's a way to monitor what each application is using of resources, and also assign them. 
	- technology to set and monitor resource usage.
	- Namespaces makes sure that each process can accesses what it should in hierarchies likt being able to access something the child has accesses to.
	- The two concepts cgroups and ns are like container.
	- ![alt text](image-3.png)
	- The Kernel sees only runc and treats it as one process
	- Cgroups and NS help us in achieving the container.
- Docker version, docker info, docker container run -it alpine:latest
	- it: interactive, terminal: be interactive with its terminal attach to its terminal IO
- `docker contianer run -it python:latest`
- `docker container ls -a`
- `container image ls`
	![alt text](image-4.png)
- NGINX: docker container run 
	- lightweight webserver that does whole bunch of things
		- Internet information server: web service, reverse proxy, load balancer, smtp, imap, pop... 
		- Open source as well.
	- docker container run 
		- But I want it to run in the background. if I open -it I would get the logs
	- we would do `docker container run -d -p 80:80
	- map the port x in the container x:y to port y in the host. 
	- Will forward anything, expose the port.
	- `docker contianer run -d -p 80:80 nginx:latest`
	- ![alt text](image-5.png); 0.0.0.0 means anything will be exposed
	- `curl https://ip:port`
- Docker Installation and privileges
- anything that has relation with containers, it's command will start with `docker container`, and anything that does something with images needs its command start with `docker image`
- `docker image pull fedora` layers will be downloaded compressed
- `docker image ls`
	- tag latest, size.
- `docker container create -it (work inside terminal in the container pass, STDIN, and show STDOUT) fedora bash`
- `docker container ls` shows the running containers but can see all stopped, started, whatever `-a`
- `docker container start -i (interactive) NAME(nice_bouman)`
- `cat /ect/*hostname*` we can't do hostname because fedora version image the container is very minimal
- `docker container run` = `pull + create + start`
- The container has a sole and only responsibility which is to bundle only 1 application and if that application is exited, the cotainer has no use. It exits as well. 
	- ![alt text](image-6.png)
- `docker container run -it python /bin/bash`
	- runs the container and enters bash shell for it.
	- if you do ps, in this container you will find it's only 1 process but what about `ps -aux`
	- if you go into python3 of the app-container and od exit will go back to bash and need to do exit again to exit the container
- `sudo apt update` `sudo apt upgrade` the layers get added to the differencing disks the layer of template etc..
- Docker does cashing and can absolutely keep records of layers and use them in future without need to go download uncompress etc...
- Better leave layer managing to docker? are layers same as images? No 
- Docker Engine:
	- docker daemon will connect the docker client to the kernel
	- contianer d
	- runc ![alt text](image-8.png)
- Images:
	- There is description files and there is actual physical files.
		- the image is just descirption just a small file how the image was created, downladed what and  configured what. and there is a build file and there are layers the physical files
		- BUILD TIME COMMANDS: any commands that were done building the container image
		- RUN TIME COMMANDS: commands during running the container.
	- build time and run time.
	- ![alt text](image-9.png)
- ![alt text](image-10.png)
- `docker container run -it --name "hepoopc" -h hadoopc asami76/hadoop-pseudo:v1.0 bash -c "/usr/local/bootstrap.sh; bash`
- Stopping a container makes it loose all data, and we need volumes to save data.
- `docker container inspect` ![alt text](image-11.png)
- Docker and Visual Studio Code:
- ![alt text](image-12.png)
- `docker container run -d --name webserver -p 80:80 nginx:latest` 
	- create container, expose port 80, you will be told welcome to nginix 
- `docker contianer cp ./file.py bbe:/tmp` to move a file from the host to the container? whatdoes this even mean? exec(open('/tmp/file1.py').read())
- Networks
	- ![alt text](image-13.png)
	- contianers are seeing each other with with but not with name
	- Web container and client container. What is the solution? temporary patch
	- `--add-host web:172.17.0.2` 
	- ![alt text](image-14.png)
	- this is a method of making containers talk and see each other in same network.
- The final fix:
	- none: the container has no network and cannot see anything else
	- bridged: default network for any container created without specifying. 
	- host: 
	- `docker container -dit(detached mode but running in background) --name alp1 alpine` 
- multi-host docker is what docker swarm about. 
- Check out 03:12:00 to find out how to connect two containers using networks. 
![alt text](image-15.png)
![alt text](image-16.png)
- The containers are designed to be immutable and you just use them when you want to test something, readonly, RO
- But sometimes apps need to write and that's when we use mutables and persistent storage.
	- ![alt text](image-17.png)
- Docker creates RW file on the host which saves the changes but when the container is stopped, this file is deleted.
![alt text](image-18.png)
- bind mount:create a folder and mount it to the container
	- `docker container run -it -v (for volume) /home/sami/docker-work/code(from host):/app/code(O_CREAT) python`
- this is persistent storage but there is a better method which is Docker Volume
	- `docker volume create myvol`
	-  `docker container run -it -v (for volume) myvol:/app/code(O_CREAT) bash`
	- ![alt text](image-19.png)
	- The better thing about volumes is because you don't have to keep records of where the mounts came from and go to. 
	- The docker volumes are created in one place for ease of transfer to different hosts.
- creating image from a container
- ![alt text](image-20.png)
- ![alt text](image-21.png)
	- `-d` will run the last command before bundling the image
- ![alt text](image-22.png)
- instruction file to avoid going into the container and doing yada yada ... but give these instrucitons to docker as docker file and will do it. 
	![alt text](image-23.png)
- Dockerfile:
	- `FROM python:latest`
	- `WORKDIR /app` will create the dir if not existent and cd into it.
	- `COPY requirements.txt .` will try to find the requirements from the current directory into /app for example requirmeents.txt = flask and could change them easily from version to version
	- `RUN pip install -r requirements.txt`
	- `COPY hello.py .`
	- `EXPOSE 5000`
	- `CMD python hello.py`
	this will not be executed during build-time but in run-time. 
		- will be in metadata not in the layers. 
		- some cmds will make changes in the layer or create a new layer.
	- docker build -t asami76/pyflast:v1.1 .(directory from whcih to build)
	- ![alt text](image-24.png) layers as being created
	- EXPOSE & CMD does not change in the image but changes only the metadata, so it's a runtime change not to the layers.
![alt text](image-25.png)
![alt text](image-26.png)
![alt text](image-27.png)
![alt text](image-28.png)
![alt text](image-29.png)
![alt text](image-30.png)
![alt text](image-31.png)
![alt text](image-32.png)
- Important note about env variables and build process and shells.
![alt text](image-33.png)
- su username is not available in all systems 
![alt text](image-34.png)
![alt text](image-35.png)
- can use either or both, one with command and other for args but sometimes one works better for something and the other for something else.
![alt text](image-36.png)
- Not best practice and you do VM stuff if you run more than one app in a container with shell script where you everything you want to run.
![alt text](image-37.png)
![alt text](image-38.png)
- Registeries
![alt text](image-39.png)
![alt text](image-40.png)
- Dcoker COmpose and microservices
![alt text](image-41.png)
![alt text](image-42.png)
![alt text](image-43.png)
![alt text](image-44.png)
- YML is just like json
	- key: value, pair...
![alt text](image-45.png)
![alt text](image-46.png)
![alt text](image-47.png)
- some configs might need vallue but other don't 
- YML is just about automation instead of writing pure commands
- service is a container that shares with another one network and storage and both can make up an application
![alt text](image-48.png)
- will build from the file in the directory
- ![alt text](image-49.png)
![alt text](image-50.png)
docker compose up or docker compose -f file; docker compose accepts this and also json files
- Why is it used?
- What is Container and Docker?
	- It's the same as git and github.
	- Docker (the software because there is also Docker Inc., the company) is just like any virtualization software like Vmware and VirtualBox

- CGroups, Namespaces & Filesystems
	- primitives that make up containers
	- these primitives are used some degree of isolation and seperation
	- containers are mechanism to run linux procs with isolation and seperation and they are done with a combination of the primitives mixture: CGroups, Namespaces & Filesystems
	- using the threee together makes up a container
- ControlGroups: cgroups
	- organize all processes in the system, account for resource usage and gather utilization, and limit and prioritize utilization
	- Subsystems: memory, cpu time, block i/o, number of discrete procs(pids), cpu & memory pinning, freezer used by docker pause, devices, network priority,
		- most of these subsystems are resource controllers, they can organize processes separately, they are concrete, 
		![alt text](image-51.png)
	- /sys/fs/cgroup kernel data structures for c groups, tasks virtual file holds all pids in the cgroup,
		- other files have settings and utilization data.
	- ![alt text](image-52.png)
- Namespaces: linux kernel primitive; isolation mechanism for resources, changes to resources withi namespace can be invisible outside the namespace , resoucemapping with permission changes,
	- frequently used in containers
	- network, filesystem(mounts), processes(pid), ipc, hostname domainnaiem uts, user group ids, cgroup
	- ![alt text](image-53.png)
	- veth: can connect different namespaces, docker run uses a seperate netwrok namespace per container, multiple containers can share a neetwork namespace: kubernetes pids, amazon ecs tasks with the awsvpc networking mode,
	- mount namespaces:"volumes" used to share data between containers or the host, 
	- clone(), unshare() syscalls to manipulate namespaces.
	- ![alt text](image-54.png)
	- ![alt text](image-55.png)
![alt text](image-56.png)