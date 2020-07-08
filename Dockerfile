ARG ECLIPSE_JDT_PATH=$WORKDIR/eclipse.jdt.ls
ARG ECLIPSE_JDT_TARGET=$ECLIPSE_JDT_PATH/org.eclipse.jdt.ls.product/target/repository

FROM openjdk:8-alpine AS build

RUN apk update
RUN apk add git maven

ARG ECLIPSE_JDT_PATH
ARG ECLIPSE_JDT_TARGET

ARG TAG=
RUN git clone --branch $TAG https://github.com/eclipse/eclipse.jdt.ls $ECLIPSE_JDT_PATH

WORKDIR $ECLIPSE_JDT_PATH
RUN $ECLIPSE_JDT_PATH/mvnw clean verify

FROM openjdk:14-alpine

RUN apk update
RUN apk add bash

ARG ECLIPSE_JDT_PATH
ARG ECLIPSE_JDT_TARGET

COPY --from=build $ECLIPSE_JDT_TARGET $ECLIPSE_JDT_TARGET

ENV ECLIPSE_WORKSPACE=/eclipse-workspace
RUN mkdir -p $ECLIPSE_WORKSPACE

WORKDIR $ECLIPSE_JDT_TARGET
COPY start.sh start.sh

CMD ["/bin/bash", "start.sh"]