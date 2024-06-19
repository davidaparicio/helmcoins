#!/bin/bash

set -e

# helm dependency build
# helm upgrade --install dockercoins .
helm upgrade --install dockercoins . --render-subchart-notes
# helm status dockercoins
# helm upgrade --install dockercoins . --render-subchart-notes #--set redis.useSubChart=false
## https://github.com/helm/helm/issues/2751#issuecomment-1217426803
# helm get notes dockercoins
# helm template --debug dockercoins . --set redis.useInternal=true --set redis.useExternal=false #--set redis.service.port=3333