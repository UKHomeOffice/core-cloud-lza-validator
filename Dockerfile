FROM node:18.20-alpine AS build

RUN apk update && apk add --no-cache python3 py3-pip g++ make
COPY /source /source
WORKDIR /source
RUN yarn install
RUN yarn build

FROM node:18.20-alpine
WORKDIR /source
COPY --from=build /source/node_modules /source/node_modules
COPY --from=build /source/package.json /source/package.json
COPY --from=build /source/packages/@aws-accelerator/accelerator/dist /source/packages/@aws-accelerator/accelerator/dist
COPY --from=build /source/packages/@aws-accelerator/accelerator/node_modules /source/packages/@aws-accelerator/accelerator/node_modules
COPY --from=build /source/packages/@aws-accelerator/config/dist /source/packages/@aws-accelerator/config/dist
COPY --from=build /source/packages/@aws-accelerator/config/node_modules /source/packages/@aws-accelerator/config/node_modules
COPY --from=build /source/packages/@aws-accelerator/constructs/node_modules /source/packages/@aws-accelerator/constructs/node_modules
COPY --from=build /source/packages/@aws-accelerator/govcloud-account-vending/dist /source/packages/@aws-accelerator/govcloud-account-vending/dist
COPY --from=build /source/packages/@aws-accelerator/govcloud-account-vending/node_modules /source/packages/@aws-accelerator/govcloud-account-vending/node_modules
COPY --from=build /source/packages/@aws-accelerator/installer/dist /source/packages/@aws-accelerator/installer/dist
COPY --from=build /source/packages/@aws-accelerator/installer/node_modules /source/packages/@aws-accelerator/installer/node_modules
COPY --from=build /source/packages/@aws-accelerator/modules/dist /source/packages/@aws-accelerator/modules/dist
COPY --from=build /source/packages/@aws-accelerator/modules/node_modules /source/packages/@aws-accelerator/modules/node_modules
COPY --from=build /source/packages/@aws-accelerator/tester/dist /source/packages/@aws-accelerator/tester/dist
COPY --from=build /source/packages/@aws-accelerator/tester/node_modules /source/packages/@aws-accelerator/tester/node_modules
COPY --from=build /source/packages/@aws-accelerator/tools/dist /source/packages/@aws-accelerator/tools/dist
COPY --from=build /source/packages/@aws-accelerator/tools/node_modules /source/packages/@aws-accelerator/tools/node_modules
COPY --from=build /source/packages/@aws-accelerator/utils/dist /source/packages/@aws-accelerator/utils/dist
COPY --from=build /source/packages/@aws-accelerator/utils/node_modules /source/packages/@aws-accelerator/utils/node_modules

COPY --from=build /source/packages/@aws-cdk-extensions/cdk-extensions/dist /source/packages/@aws-cdk-extensions/cdk-extensions/dist
COPY --from=build /source/packages/@aws-cdk-extensions/cdk-extensions/node_modules /source/packages/@aws-cdk-extensions/cdk-extensions/node_modules
COPY --from=build /source/packages/@aws-cdk-extensions/cdk-plugin-assume-role/dist /source/packages/@aws-cdk-extensions/cdk-plugin-assume-role/dist
COPY --from=build /source/packages/@aws-cdk-extensions/cdk-plugin-assume-role/node_modules /source/packages/@aws-cdk-extensions/cdk-plugin-assume-role/node_modules

COPY --from=build /source/packages/@aws-accelerator/accelerator/lib/config-validator.ts /source/packages/@aws-accelerator/accelerator/lib/config-validator.ts

CMD ts-node /source/packages/@aws-accelerator/accelerator/dist/@aws-accelerator/accelerator/lib/ ../config

