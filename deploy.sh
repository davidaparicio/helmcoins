#!/bin/bash

set -e

# helm dependency build
helm upgrade --install dockercoins .
# helm upgrade --install dockercoins . --set redis.useSubChart=false