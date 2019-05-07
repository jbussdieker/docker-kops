FROM ubuntu

RUN apt-get -y update && \
  apt-get -y install curl

ARG kops_version

RUN : "${kops_version:?Must specify version}"

RUN curl -OL https://github.com/kubernetes/kops/releases/download/${kops_version}/kops-linux-amd64 && \
  chmod +x kops-linux-amd64 && \
  mv kops-linux-amd64 /usr/local/bin/kops
