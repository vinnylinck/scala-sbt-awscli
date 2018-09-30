FROM openjdk:8-alpine

ENV SBT_VERSION 1.2.3

# Build dependencies
RUN apk --no-cache update
RUN apk upgrade
RUN apk add bash
RUN apk add --no-cache curl

# Installing sbt
RUN curl -L -o sbt-$SBT_VERSION.tgz https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz
RUN tar -zxvf sbt-$SBT_VERSION.tgz

ENV SBT_HOME=/sbt
ENV PATH $PATH:$SBT_HOME/bin

# Bootstrapping SBT
RUN sbt clean

# Installing AWSCLI
RUN apk --no-cache add python py-pip py-setuptools ca-certificates curl groff less && \
    pip install --upgrade pip && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/*