#!/bin/bash
#FLUX: --job-name=faux-bits-8186
#FLUX: -t=900
#FLUX: --urgency=16

export PSM2_MULTI_EP='1'

. $SANDBOX/spack/share/spack/setup-env.sh
spack load -r mochi-bake
spack find --loaded
export PSM2_MULTI_EP=1
echo "### NOTE: all benchmarks are using numactl to keep processes on socket 0"
echo "## Margo OFI/PSM2 (vector benchmark with len 1, 512KiB xfers):"
mpirun numactl -N 0 -m 0 ./margo-p2p-vector -x 524288 -n "psm2://" -c 1 -D 20
sleep 1
echo "## Margo OFI/PSM2 (vector benchmark with len 256, 512KiB xfers):"
mpirun numactl -N 0 -m 0 ./margo-p2p-vector -x 524288 -n "psm2://" -c 1 -D 20 -v 256
