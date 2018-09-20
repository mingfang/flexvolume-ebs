FROM python:3.6-alpine

RUN apk update
RUN apk add build-base
RUN pip install --upgrade pip

RUN apk add bash jq groff xfsprogs-extra
RUN pip install awscli

COPY docker/ebs /ebs
COPY docker/install.sh /install.sh

COPY flexvolume-ebs /flexvolume-ebs

ENTRYPOINT ["/flexvolume-ebs/ebs"]