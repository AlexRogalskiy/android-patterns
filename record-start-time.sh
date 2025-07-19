#!/bin/sh

set -e

tmpfile=$(mktemp /tmp/tilt-example-android.XXXXXX)

cat build.txt |
  sed -e "s/startTimeSecs = .*;/startTimeSecs = $(date +%-s);/" |
  sed -e "s/startTimeNanos = .*;/startTimeNanos = $(date +%-N);/" >$tmpfile

mv $tmpfile build.txt
