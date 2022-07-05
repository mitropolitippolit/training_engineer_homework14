FROM alpine:latest
EXPOSE 8080
ENV CATALINA_HOME=/opt/tomcat
ENV TOMCAT_VERSION=9.0.64
WORKDIR /opt
RUN apk add --update git maven openjdk8 wget &&\
    wget https://dlcdn.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz &&\
    tar xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz &&\
    mv apache-tomcat-${TOMCAT_VERSION} tomcat &&\
    rm -rf apache-tomcat-${TOMCAT_VERSION}.tar.gz &&\
    rm -rf tomcat/webapps/*
WORKDIR /work
RUN git clone https://github.com/daticahealth/java-tomcat-maven-example
WORKDIR /work/java-tomcat-maven-example
RUN mvn package &&\
    mv target/java-tomcat-maven-example.war ${CATALINA_HOME}/webapps/ROOT.war
