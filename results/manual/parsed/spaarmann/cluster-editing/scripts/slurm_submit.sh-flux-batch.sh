#!/bin/bash
#FLUX: --job-name=cluster-editing
#FLUX: --queue=ether
#FLUX: -t=604800
#FLUX: --urgency=16

set -e
set -u
INSTANCE=$1
RUST_LOG=info RUST_BACKTRACE=1 ./cluster-editing $INSTANCE 2>&1 | tee $INSTANCE.out
exit
