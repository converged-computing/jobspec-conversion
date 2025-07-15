#!/bin/bash
#FLUX: --job-name=dirty-nunchucks-9860
#FLUX: -t=900
#FLUX: --priority=16

export HOME='$SANDBOX'
export PSM2_MULTI_EP='1'

export HOME=$SANDBOX
. $SANDBOX/spack/share/spack/setup-env.sh
spack env activate mochi-regression
spack find -vN
export PSM2_MULTI_EP=1
echo "### NOTE: all benchmarks are using numactl to keep processes on socket 0"
echo "## Margo PSM2/PSM2 (vector benchmark with len 1, 512KiB xfers):"
mpirun numactl -N 0 -m 0 ./margo-p2p-vector -x 524288 -n "psm2+psm2://" -c 1 -D 20
sleep 1
echo "## Margo PSM2/PSM2 (vector benchmark with len 256, 512KiB xfers):"
mpirun numactl -N 0 -m 0 ./margo-p2p-vector -x 524288 -n "psm2+psm2://" -c 1 -D 20 -v 256
