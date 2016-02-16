# image name lzh/glance-api:liberty
FROM 10.64.0.50:5000/lzh/openstackbase:liberty

MAINTAINER Zuhui Liu penguin_tux@live.com

ENV BASE_VERSION 2015-01-07
ENV OPENSTACK_VERSION liberty
ENV BUID_VERSION 2016-02-16

ADD ceph.repo /etc/yum.repos.d/ceph.repo

RUN yum update -y && \
         yum install -y openstack-glance python-glance python-glanceclient python-rbd && \
         rm -rf /var/cache/yum/*

RUN cp -rp /etc/glance/ /glance && \
         rm -rf /etc/glance/* && \
         rm -rf /var/log/glance/*

VOLUME ["/etc/glance"]
VOLUME ["/var/log/glance"]
VOLUME ["/etc/ceph/"]

ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ADD glance-api.ini /etc/supervisord.d/glance-api.ini

EXPOSE 9292

ENTRYPOINT ["/usr/bin/entrypoint.sh"]