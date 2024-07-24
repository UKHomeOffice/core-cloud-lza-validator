FROM node:18.20-alpine

RUN apk update && apk add --no-cache python3 py3-pip g++ make

COPY /source /source

WORKDIR /source

RUN yarn install

RUN yarn build

CMD yarn validate-config ../config

