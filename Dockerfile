# Copyright (c) 2020 , Veepee
#
# Permission  to use,  copy, modify,  and/or distribute  this software  for any
# purpose  with or  without  fee is  hereby granted,  provided  that the  above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS  SOFTWARE INCLUDING ALL IMPLIED  WARRANTIES OF MERCHANTABILITY
# AND FITNESS.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL  DAMAGES OR ANY DAMAGES  WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER  TORTIOUS ACTION,  ARISING OUT  OF  OR IN  CONNECTION WITH  THE USE  OR
# PERFORMANCE OF THIS SOFTWARE.

FROM docker.registry.vptech.eu/python:3.10-alpine

RUN apk update  --quiet && \
    apk upgrade --quiet && \
    apk add --no-cache --quiet \
      build-base \
      ca-certificates \
      cargo \
      docker \
      docker-py \
      gcc \
      git \
      libffi-dev \
      linux-headers \
      make \
      musl-dev \
      openssh-client \
      openssl-dev \
      tar

COPY requirements.txt /tmp

RUN pip3 install --no-cache-dir --requirement /tmp/requirements.txt

RUN ansible-galaxy collection install community.docker && \
    ansible-galaxy collection install community.general

RUN apk del --no-cache --quiet \
      build-base \
      gcc \
      make  && \
    rm -rf /var/cache/apk/*

CMD [ "molecule", "--version" ]

HEALTHCHECK NONE
# EOF
