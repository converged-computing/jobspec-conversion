#!/bin/bash
#FLUX: --job-name=margo-p2p-bw
#FLUX: -N=2
#FLUX: --queue=batch
#FLUX: -t=900
#FLUX: --urgency=16

. /ccs/home/carns/working/src/spack/share/spack/setup-env.sh
spack env activate crusher-demo
spack find -vN
srun -n 2 --ntasks-per-node=1 /ccs/home/carns/working/install-crusher/bin/margo-p2p-bw -x 8388608 -n "cxi://" -c 8 -D 20
