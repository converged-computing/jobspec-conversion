#!/bin/bash
#FLUX: --job-name=nell_t2
#FLUX: -c=56
#FLUX: --queue=fat
#FLUX: -t=43200
#FLUX: --urgency=16

export OMP_NUM_THREADS='56'
export KMP_AFFINITY='granularity=fine,compact,1'

export OMP_NUM_THREADS=56
export KMP_AFFINITY=granularity=fine,compact,1
./build/Linux-x86_64/bin/splatt cpd -v --stream=1 -r 32 -t 2 --reg=frob,1e-2,1 ../hpctensor/nell-1M.tns
