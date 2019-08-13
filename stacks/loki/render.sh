#!/bin/sh

set -e

BUILD_DIR=$(mktemp -d)
ROOT_DIR=$(git rev-parse --show-toplevel)
SRC="loki-stack"
VERSION="0.15.0"
STACK="loki"

cp -r "$ROOT_DIR"/src/"$SRC"/"$VERSION" $BUILD_DIR
cp -r "$ROOT_DIR"/stacks/"$STACK" $BUILD_DIR
cd $BUILD_DIR

# Remove test templates
find "$VERSION" -type d -name tests -print0 | xargs -0 rm -rf

# render yaml
helm template \
  --name $STACK \
  --namespace monitoring \
  "$VERSION" > "$ROOT_DIR"/stacks/"$STACK"/manifest.yaml
