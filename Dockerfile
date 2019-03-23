ARG VERSION=3.9

FROM alpine:${VERSION}

RUN apk add --update \
    git \
    nodejs \
    nodejs-npm && \
    npm install -g md2gslides && \
    rm -rf /var/cache/apk/*

WORKDIR /root/.credentials
COPY md2gslides.json .

WORKDIR /md2gslides
ARG SLIDEFILE
COPY ./${SLIDEFILE} .

ENV FILE=${SLIDEFILE}
CMD md2gslides ${FILE} --no-browser