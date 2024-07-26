FROM node:18-alpine3.20
WORKDIR /source
COPY landing-zone-accelerator-on-aws/source .
# COPY lza-validator.sh ./lza-validator.sh

RUN export NODE_OPTIONS=--max_old_space_size=8192 \
    && yarn install \
    && yarn build \
    && yarn cache clean

# ENTRYPOINT ["/lza/lza-validator.sh"]
# CMD ["/lza/config/"]
CMD yarn validate-config ../config

