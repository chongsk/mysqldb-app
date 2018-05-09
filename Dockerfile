FROM ubuntu:16.04
MAINTAINER SKChong

RUN apt-get update
RUN apt-get install -y curl php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-mcrypt php7.0-curl
RUN phpenmod pdo_mysql

RUN curl https://releases.hashicorp.com/consul-template/0.18.5/consul-template_0.18.5_linux_amd64.tgz -o consul-template.tgz
RUN gunzip consul-template.tgz
RUN tar -xf consul-template.tar
RUN mv consul-template /opt/consul-template
RUN rm -rf /tmp/consul-template*


WORKDIR /usr/src/myapp

CMD /opt/consul-template   -template="$CONSUL_TEMPLATE_URL:/opt/conn.inc.php" -once -consul-addr=$CONSUL_HTTP_ADDR     -vault-addr=$VAULT_ADDR     -vault-token=$VAULT_TOKEN 	-vault-renew-token=false  -vault-ssl-verify=false -log-level=debug  -exec "bash" && php $PHP_SCRIPTNAME







