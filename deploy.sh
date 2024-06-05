#!/bin/bash

set -e

helm upgrade --install dockercoins .
#helm upgrade --install dockercoins . --set redis.useSubChart=false