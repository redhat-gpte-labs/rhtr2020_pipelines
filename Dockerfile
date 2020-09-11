FROM quay.io/openshifthomeroom/workshop-dashboard:5.0.0

ENV OCP_CLIENT_RELEASE=4.5.8

USER root

COPY . /tmp/src

RUN rm -rf /tmp/src/.git* && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
    chmod -R g+w /tmp/src

# Get OpenShift Client
RUN wget -O /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OCP_CLIENT_RELEASE}/openshift-client-linux-${OCP_CLIENT_RELEASE}.tar.gz && \
    tar xzf /tmp/oc.tar.gz -C /opt/workshop/bin && \
    rm -f /tmp/oc.tar.gz

USER 1001

RUN /usr/libexec/s2i/assemble
