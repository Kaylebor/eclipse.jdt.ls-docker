ARG ECLIPSE_JDT_PATH=$WORKDIR/eclipse.jdt.ls
ARG ECLIPSE_JDT_TARGET=$ECLIPSE_JDT_PATH/org.eclipse.jdt.ls.product/target/repository

FROM archlinux:latest AS build

RUN pacman -Sy --noconfirm
RUN pacman -S --noconfirm git jdk8-openjdk maven gradle bash

ARG ECLIPSE_JDT_PATH
ARG ECLIPSE_JDT_TARGET

ARG TAG=
RUN git clone $([[ ! -z $TAG ]] && --branch $TAG) https://github.com/eclipse/eclipse.jdt.ls $ECLIPSE_JDT_PATH

WORKDIR $ECLIPSE_JDT_PATH
RUN JAVA_HOME='/usr/lib/jvm/java-8-openjdk/' $ECLIPSE_JDT_PATH/mvnw clean verify

FROM archlinux:latest

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm jdk-openjdk bash

ARG ECLIPSE_JDT_PATH
ARG ECLIPSE_JDT_TARGET

COPY --from=build $ECLIPSE_JDT_TARGET $ECLIPSE_JDT_TARGET

ENV ECLIPSE_WORKSPACE=/eclipse-workspace
RUN mkdir -p $ECLIPSE_WORKSPACE

WORKDIR $ECLIPSE_JDT_TARGET
COPY start.sh start.sh

CMD ["/bin/bash", "start.sh"]