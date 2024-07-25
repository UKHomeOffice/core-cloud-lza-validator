# FROM node:18.20-alpine

# RUN apk update && apk add --no-cache python3 py3-pip g++ make
# COPY /source /source
# WORKDIR /source
# RUN export NODE_OPTIONS=--max_old_space_size=8192
# RUN yarn install
# RUN yarn build
# RUN yarn cache clean

FROM --platform=linux/amd64 node:lts-alpine3.17
WORKDIR /lza
COPY . .
# COPY lza-validator.sh ./lza-validator.sh

RUN mkdir config
RUN cd source \
    && export NODE_OPTIONS=--max_old_space_size=8192 \
    && yarn install \
    && yarn build \
    && yarn cache clean

CMD yarn validate-config ../config

