rpi-tomcat
==============

[![dockeri.co](http://dockeri.co/image/rlogiacco/rpi-tomcat)](https://registry.hub.docker.com/u/rlogiacco/rpi-tomcat/)

Based on Alpine for ARM and OpenJDK this image delivers a Tomcat container.

# Description
You should run this container on the background and mount the volume with your web app inside.

Includes:

 - OpenJDK
 - Apache Tomcat
 
## Volumes
Exports a volume on `/usr/share/tomcat/webapps`.
You can mount the volume on run to a local directory containing your war file or exploded war directory.
If you need the management app, remember to have a copy on your hosts volume mount point.

## Ports
Two ports are exposed:

 - 8080: default Tomcat HTTP port
 - 8009: default Tomcat AJP port

Remember to map the ports to the docker host on run.


# How to run the container
## Using docker
To get the container up and running, run:
 
```
sudo docker run -d -p 8080:8080 -p 8009:8009 -v /home/user/appname:/usr/share/tomcat/webapps rlogiacco/rpi-tomcat
```

Remember to change `/home/user/appname` to the directory where the war is stored.


# Links

- [Source Repository](https://github.com/rlogiacco-docker/rpi-tomcat)
- [Dockerfile](https://github.com/rlogiacco-docker/rpi-tomcat/blob/master/Dockerfile)
- [DockerHub](https://registry.hub.docker.com/u/rlogiacco/rpi-tomcat/)
