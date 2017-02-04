rpi-tomcat
==============

[![](https://images.microbadger.com/badges/image/rlogiacco/rpi-tomcat.svg)](https://microbadger.com/images/rlogiacco/rpi-tomcat) [![](https://images.microbadger.com/badges/version/rlogiacco/rpi-tomcat.svg)](https://microbadger.com/images/rlogiacco/rpi-tomcat)

Based on Alpine for ARM this image delivers a Tomcat container based on OpenJDK.

# Description
You should run this container on the background and mount the volume with your webapps content or wars inside.

Includes:

 - OpenJDK
 - Tomcat
 
# Volumes
Exports a volume on `/usr/share/tomcat/webapps` where webapps are read and stored.

# Ports
Two ports are exposed:

 - 8080: default Tomcat HTTP port
 - 8009: default Tomcat AJP port

Remember to map the ports to the docker host on run.


# Run the container using docker
To get the container up and running:
 
```
sudo docker run -d -p 8080:8080 -p 8009:8009 -v /home/user/webapps:/usr/share/tomcat/webapps rlogiacco/rpi-tomcat
```

Remember to change `/usr/share/tomcat/webapps` to the directory hosting your webapps!

### Environment Parameters

The following environment parameters can be set:

 - `ADMIN_USERNAME` the username with admin privileges (default: `admin`)
 - `ADMIN_PASSWORD` the password to obtain admin privileges (optional: generated and printed on console)
 - `TOMCAT_MIRROR`  during image build sets the mirror used to download the archive
 - `TOMCAT_VERSION` during image build provides the tomcat version to install
 


# Links

 - [Source Repository](https://github.com/rlogiacco-docker/rpi-tomcat)
 - [Dockerfile](https://github.com/rlogiacco-docker/rpi-tomcat/blob/master/Dockerfile)
 - [DockerHub](https://registry.hub.docker.com/u/rlogiacco/rpi-tomcat/)