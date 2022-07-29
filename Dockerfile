FROM ubuntu:20.04
ENV JAVA_HOME=/opt/middleware/jdk-11.0.1
ENV TOMCAT_HOME=/opt/middleware/apache-tomcat-9.0.65
ENV PATH=$PATH:$JAVA_HOME/bin:$TOMCAT_HOME/bin

RUN mkdir -p /opt/middleware
WORKDIR /opt/middleware
ADD https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz .
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz .

RUN tar -xzvf https://download.java.net/java/ga/jdk11/openjdk-11_linux-x64_bin.tar.gz
RUN tar -xzvf https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz
RUN rm *.tar.gz

COPY target/foodies.war $TOMCAT_HOME/webapps
COPY run.sh .
RUN chmod u+x run.sh
ENTRYPOINT ["./run.sh"]
CMD ["tail", "-f", "dev/null"] 
