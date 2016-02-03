#!/bin/bash
#
#   Author: Rohith
#   Date: 2016-02-02 23:24:08 +0000 (Tue, 02 Feb 2016)
#
#  vim:ts=2:sw=2:et
#

OUTPUT_DIR=${OUTPUT_DIR:-""}
INTERVAL=${INTERVAL:="10"}

usage() {
  cat <<EOF
  Usage: $(basename $0) [options]
    --output-dir|-o  PATH      : the directory to write the files to (OUTPUT_DIR)
    --bucket|-b      NAME      : the aws bucket in s3://NAME/KEY format (AWS_BUCKET)
    --interval|-I    SECONDS   : the interval in seconds between syncing the files (INTERVAL)
    --help|-h                  : display this usage menu
EOF
  if [ -n "${1}" ]; then
    echo "[error] $@"
    exit 1
  fi
  exit 0
}

while [ $# -ne 0 ]; do
  case "$1" in
    --output-dir|-o)    OUTPUT_DIR=$2; shift 2 ;;
    --bucket|-b)        AWS_BUCKET=$2; shift 2 ;;
    --interval|-i)      INTERVAL=$2;   shift 2 ;;
    --help|-h)          usage; ;;
    *)                  shift; ;;
  esac
done

echo "synchronization from: $AWS_BUCKET, dest: ${OUTPUT_DIR} internal: ${INTERVAL}"

[ -z "${AWS_BUCKET}" ] && usage "you have not specified a bucket to synchronize from"
[ -z "${OUTPUT_DIR}" ] && usage "you have not specified a output directory"

while true; do
  aws s3 sync --only-show-errors ${AWS_BUCKET} ${OUTPUT_DIR}
  sleep $INTERVAL
done
