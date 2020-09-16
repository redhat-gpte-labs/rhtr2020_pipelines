FROM quay.io/openshifthomeroom/workshop-dashboard:5.0.0

ENV OCP_CLIENT_RELEASE=4.5.9
ENV TKN_RELEASE=0.9.0
ENV ODO_RELEASE=1.2.6
ENV HELM_RELEASE=3.2.3

USER root

COPY . /tmp/src

RUN rm -rf /tmp/src/.git* && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
    chmod -R g+w /tmp/src

# Update OpenShift Client
RUN wget -O /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${OCP_CLIENT_RELEASE}/openshift-client-linux-${OCP_CLIENT_RELEASE}.tar.gz && \
    tar xzf /tmp/oc.tar.gz -C /opt/workshop/bin && \
    rm -f /tmp/oc.tar.gz

# Update ODO Client
RUN wget -O /tmp/odo.tar.gz https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/odo/v${ODO_RELEASE}/odo-linux-amd64.tar.gz && \
    tar xzf /tmp/odo.tar.gz -C /opt/workshop/bin && \
    rm -f /tmp/odo.tar.gz

# Install tkn CLI
RUN wget -O /tmp/tkn.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/pipeline/${TKN_RELEASE}/tkn-linux-amd64-${TKN_RELEASE}.tar.gz && \
    tar xzf /tmp/tkn.tar.gz -C /opt/app-root/bin && \
    rm -f /tmp/tkn.tar.gz

# Install Helm
RUN wget -O /opt/app-root/bin/helm https://mirror.openshift.com/pub/openshift-v4/clients/helm/${HELM_RELEASE}/helm-linux-amd64 && \
    chmod 775 /opt/app-root/bin/helm

USER 1001

RUN /usr/libexec/s2i/assemble
