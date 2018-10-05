Using the prebuilt image
========================

The public Docker Hub repository is here:
https://hub.docker.com/r/sraillard/alpine-android-ndk/

Get the image:
```
docker pull sraillard/alpine-android-ndk:r18
```

To compile a project:
```
docker run -rm --mount source=/path/to/ndk/project/,destination=/source,type=bind --workdir=/source sraillard/alpine-android-ndk:r18 ndk-build
```

Dependencies
============

* Docker Alpine Linux base container from Docker hub:
  - https://hub.docker.com/_/alpine/
  - Very small base image
* Android NDK from Google:
  - https://developer.android.com/ndk/downloads/
  - Subject to license agreement
  - 531 MB download (zip file)
  - Latest version is **r18**
* glibc for Alpine Linux:
  - https://github.com/sgerrand/alpine-pkg-glibc/
  - Allow for use of applications needing glibc (like Android tools)
  - Discussion: https://github.com/gliderlabs/docker-alpine/issues/169
  - Source#1: https://hub.docker.com/r/alvrme/alpine-android/~/dockerfile/
  - Source#2: https://github.com/frol/docker-alpine-glibc

Step by step build
==================

Launch a shell from the Alpine Linux container:
```
docker pull alpine
docker run -it alpine
```

In the container shell:
```
apk add --no-cache nano bash make file
mkdir /ndk
cd /ndk
wget -O ndk.zip https://dl.google.com/android/repository/android-ndk-r18-linux-x86_64.zip
unzip ndk.zip
rm ndk.zip
wget https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -O /etc/apk/keys/sgerrand.rsa.pub
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk -O /tmp/glibc.apk
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-bin-2.28-r0.apk -O /tmp/glibc-bin.apk
apk add --no-cache /tmp/glibc.apk /tmp/glibc-bin.apk
rm /tmp/glibc.apk /tmp/glibc-bin.apk
exit
```

Save the container modifications:
```
docker ps -a (get the container ID)
docker commit ID test-ndk
```

Test: compile a NDK project:
```
 docker run --mount source=/path/to/ndk/project/,destination=/source,type=bind --workdir=/source test-ndk /ndk/android-ndk-r18/ndk-build
```
