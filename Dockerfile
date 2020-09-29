FROM openjdk:8-jre

ENV LANG=C.UTF-8
ENV ARCHIVESSPACE_LOGS="/dev/null"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
      git \
      default-mysql-client \
      sendmail \
      wget \
      unzip && \
      rm -rf /var/lib/apt/lists/*

COPY archivesspace /opt/archivesspace
COPY mysql-connector-java-5.1.48-bin.jar /opt/archivesspace/lib
COPY config.rb /opt/archivesspace/config/config.rb
COPY plugins /opt/archivesspace/plugins

EXPOSE 8080 8081 8089

# update with the list of plugins to initialize as needed
RUN /opt/archivesspace/scripts/initialize-plugin.sh plugin_1 \
 && /opt/archivesspace/scripts/initialize-plugin.sh plugin_2

COPY start-archivesspace.sh /opt/archivesspace
CMD ["/opt/archivesspace/start-archivesspace.sh"]
