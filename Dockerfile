# The latest Alpine Linux available
FROM alpine:3.8

LABEL maintainer="Sebastien RAILLARD"

# NDK version to use
ENV NDK_VERSION="android-ndk-r18"

# Set default locale
ENV LANG="C.UTF-8"

# glibc version to be installed
ENV GLIBC_VERSION "2.28-r0"

# Installing packages and glibc
RUN apk add --no-cache nano bash make file && \
	wget https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -O /etc/apk/keys/sgerrand.rsa.pub && \
	wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk -O /tmp/glibc.apk && \
	wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk -O /tmp/glibc-bin.apk && \
	apk add --no-cache /tmp/glibc.apk /tmp/glibc-bin.apk && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*

# Download and unzip the Android NDK
RUN wget -O /${NDK_VERSION}.zip https://dl.google.com/android/repository/${NDK_VERSION}-linux-x86_64.zip && \
	unzip /${NDK_VERSION}.zip && \
	rm /${NDK_VERSION}.zip

# Add ndk-build to the search path
ENV PATH="/${NDK_VERSION}/:${PATH}"
