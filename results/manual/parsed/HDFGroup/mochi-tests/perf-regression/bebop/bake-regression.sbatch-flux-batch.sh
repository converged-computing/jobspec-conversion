#!/bin/bash
#FLUX: --job-name=doopy-cat-2014
#FLUX: -N=2
#FLUX: --queue=bdwall
#FLUX: -t=900
#FLUX: --urgency=16

export HOME='$SANDBOX'
export PSM2_MULTI_EP='1'

export HOME=$SANDBOX
. $SANDBOX/spack/share/spack/setup-env.sh
spack env activate mochi-regression
spack find -vN
export PSM2_MULTI_EP=1
echo "### NOTE: all benchmarks are using numactl to keep processes on socket 0"
echo "## Bake OFI/PSM2 (bdw):"
rm -f /dev/shm/foo.dat
bake-mkpool -s 60G /dev/shm/foo.dat
srun numactl -N 0 -m 0 ./bake-p2p-bw -x 16777216 -m 34359738368 -n psm2:// -p /dev/shm/foo.dat -c 1 
echo "## Bake OFI/PSM2 (8x concurrency, bdw):"
rm -f /dev/shm/foo.dat
bake-mkpool -s 60G /dev/shm/foo.dat
srun numactl -N 0 -m 0 ./bake-p2p-bw -x 16777216 -m 34359738368 -n psm2:// -p /dev/shm/foo.dat -c 8
echo "## Bake OFI/PSM2 (bdw, 12 rpc es):"
rm -f /dev/shm/foo.dat
bake-mkpool -s 60G /dev/shm/foo.dat
srun numactl -N 0 -m 0 ./bake-p2p-bw -x 16777216 -m 34359738368 -n psm2:// -p /dev/shm/foo.dat -c 1 -r 12
echo "## Bake OFI/PSM2 (8x concurrency, bdw, 12 rpc es):"
rm -f /dev/shm/foo.dat
bake-mkpool -s 60G /dev/shm/foo.dat
srun numactl -N 0 -m 0 ./bake-p2p-bw -x 16777216 -m 34359738368 -n psm2:// -p /dev/shm/foo.dat -c 8 -r 12
echo "## Bake OFI/PSM2 (bdw, 12 rpc es, pipelining):"
rm -f /dev/shm/foo.dat
bake-mkpool -s 60G /dev/shm/foo.dat
srun numactl -N 0 -m 0 ./bake-p2p-bw -x 16777216 -m 34359738368 -n psm2:// -p /dev/shm/foo.dat -c 1 -r 12 -i
echo "## Bake OFI/PSM2 (8x concurrency, bdw, 12 rpc es, pipelining):"
rm -f /dev/shm/foo.dat
bake-mkpool -s 60G /dev/shm/foo.dat
srun numactl -N 0 -m 0 ./bake-p2p-bw -x 16777216 -m 34359738368 -n psm2:// -p /dev/shm/foo.dat -c 8 -r 12 -i
