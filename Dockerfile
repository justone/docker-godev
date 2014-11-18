FROM golang:cross
MAINTAINER Nate Jones <nate@endot.org>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install vim-nox locales sudo -y

# Set up UTF-8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen en_US.UTF-8
ENV LC_ALL en_US.utf8

# Install necessary go tools
RUN go get github.com/mitchellh/gox
RUN go get github.com/tools/godep
RUN go get code.google.com/p/go.tools/cmd/goimports

# Add my user
RUN addgroup --gid 1000 nate
RUN adduser --uid 1000 --gid 1000 nate --gecos "" --disabled-password
RUN chown -R nate:nate /go

# Ensure that color and time zone are correct
ENV TERM xterm-256color
ENV TZ /usr/share/zoneinfo/America/Los_Angeles

# Allow me to sudo
RUN echo "nate   ALL=NOPASSWD: ALL" >> /etc/sudoers

USER nate
WORKDIR /home/nate
