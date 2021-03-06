#
# Dockerfile for machine learning stack
#
#
FROM docker.io/centos/python-36-centos7
MAINTAINER Bob Kozdemba <bkozdemba@gmail.com>
EXPOSE 8888 6006
ENV OC_VERSION=3.10.53
ENV ODO_VERSION=v0.0.13
    
### Setup user for build execution and application runtime
ENV APP_ROOT=/opt/app-root
RUN mkdir -p ${APP_ROOT}/{bin,src} && \
    chmod -R u+x ${APP_ROOT}/bin && chgrp -R 0 ${APP_ROOT} && chmod -R g=u ${APP_ROOT}
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}

USER root

# Install OCP client binaries.
RUN yum -y install git wget bash-completion && yum clean all -y

RUN easy_install -U pip
RUN pip install --upgrade tensorflow matplotlib pillow scipy jupyter 

#RUN curl https://mirror.openshift.com/pub/openshift-v3/clients/${OC_VERSION}/linux/oc.tar.gz | tar zxf - -O > ${APP_ROOT}/bin/oc && \
#    wget https://dl.bintray.com/odo/odo/latest/linux-amd64/odo -O ${APP_ROOT}/bin/odo && \    
#    chmod u=rwx,g=rx,o=rx ${APP_ROOT}/bin/{oc,odo}


### Containers should NOT run as root as a good practice
USER 14045
WORKDIR ${APP_ROOT}

### user name recognition at runtime w/ an arbitrary uid - for OpenShift deployments
# ENTRYPOINT [ "uid_entrypoint" ]
VOLUME ${APP_ROOT}/logs ${APP_ROOT}/data

CMD /usr/bin/tail -f /dev/null

