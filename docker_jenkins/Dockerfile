FROM jenkins/jenkins:2.228

USER root
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" &&\
    unzip awscli-bundle.zip &&\
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

RUN apt-get update -y && apt-get install -y cron zip vim gosu python-pip jq && apt-get clean
RUN pip install detect-secrets
RUN pip install envsubst
Run cmd.cat/envsubst envsubst


# Configure Timezone
RUN \
rm -f /etc/localtime && \
ln -s /usr/share/zoneinfo/America/New_York /etc/localtime && \
echo 'America/New_York' > /etc/timezone && \
dpkg-reconfigure --frontend noninteractive tzdata

RUN curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose


USER jenkins
ENV JENKINS_HOME /var/jenkins_home/
WORKDIR /var/jenkins_home/
COPY files/plugins.txt /var/wont_persist/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /var/wont_persist/plugins.txt
COPY files/casc_configs /var/wont_persist/casc_configs
ENV CASC_JENKINS_CONFIG /var/wont_persist/casc_configs
COPY files/jenkins_wrapper.sh /var/wont_persist/jenkins_wrapper.sh
USER root
RUN chown -R 1000:1000 /var/wont_persist


ENV JAVA_OPTIONS -Djava.awt.headless=true -Djavax.net.ssl.trustStore=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.232.b09-0.el7_7.x86_64/jre/lib/security/cacerts -Djavax.net.ssl.trustStorePassword=changeit

ENTRYPOINT ["/sbin/tini", "--", "/var/wont_persist/jenkins_wrapper.sh"]
