FROM quay.io/keaosolutions/generic-base:latest

RUN curl -L# http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.0.3/ambari.repo -o /etc/yum.repos.d/ambari.repo \
    && yum install -y ambari-server \
    && yum clean all

WORKDIR /tmp

ADD https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.41.tar.gz /var/lib/ambari-server/resources/mysql-jdbc-driver.jar
ADD https://jdbc.postgresql.org/download/postgresql-42.0.0.jar /var/lib/ambari-server/resources/postgres-jdbc-driver.jar
ADD ./rc.local /etc/rc.d/rc.local
RUN chmod +x /etc/rc.d/rc.local
RUN systemctl enable ambari-server

RUN echo DefaultEnvironment=\"JAVA_HOME=$JAVA_HOME\" >> /etc/systemd/system.conf

EXPOSE 8080
