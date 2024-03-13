#!/bin/sh

PKG="$@"

echo "Start installing $PKG" \
  || echo "  Trying community..." \
  && apk add "$PKG" --repository=https://$MIRROR/alpine/edge/community 2>/dev/null \
  && echo "  Success!" \
  && exit 0 \
  || echo "  Trying main..." \
  && apk add "$PKG" --repository=https://$MIRROR/alpine/edge/main      2>/dev/null \
  && echo "  Success!" \
  && exit 0 \
  || echo "  Failed!"
